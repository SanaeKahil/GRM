<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="myAppSpringBoot.Models.BesoinModel" %>
<%@ page import="java.util.List" %>
<%@ page import="myAppSpringBoot.Models.PersonnelAdministrationModel" %>
<%@ page import="myAppSpringBoot.Models.DepartementModel" %>
<%@ page import="myAppSpringBoot.Models.ImprimanteModel" %>
<%@ page import="myAppSpringBoot.Models.OrdinateurModel" %>
<%@ page import="myAppSpringBoot.Models.PanneModel" %>
<%@ page import="myAppSpringBoot.Models.RessourceModel" %>
<%@ page import="myAppSpringBoot.Controllers.PanneController" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Liste des ressources</title>
<style>

    #besoinsTable {
         width: 90%;
         border-collapse: collapse;
         margin-left: 23px;
    }

    #besoinsTable th,
    #besoinsTable td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }

    #besoinsTable th {
        background-color: #f2f2f2;
        color: #333;
    }

    #besoinsTable tr:nth-child(even) {
         background-color: #f9f9f9;
    }

    #besoinsTable tr:hover {
         background-color: #f2f2f2;
    }
    
    .action-icons i {
        margin-right: 15px;
        cursor: pointer;
    }
    .report-icon {
    font-size: 24px; 
    color: #FF5733; 
    margin-right: 10px; 
    padding-left:13px;
}

.modal {
  display: none; 
  position: fixed; 
  z-index: 9999; 
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.5); 
}

/* Contenu de la modal */
.modal-content {
  background-color: #fefefe;
  margin: 15% auto; 
  padding: 20px;
  border: 1px solid #888;
  width: 80%; 
  max-width: 600px; 
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); 
}
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

#confirmButton {
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 3px;
  padding: 10px 20px;
  cursor: pointer;
}

#confirmButton:hover {
  background-color: #0056b3;
}

#datePicker {
  width: 100%;
  padding: 10px;
  margin-top: 10px;
  box-sizing: border-box;
}
</style>
</head>
<body>

<% 
List<RessourceModel> listRessources = (List<RessourceModel>) session.getAttribute("ressources");
PersonnelAdministrationModel chef = (PersonnelAdministrationModel) session.getAttribute("ChefDepartement");
%>

<table id="besoinsTable" class="display">
<thead>
    <tr>
        <th>Numéro inventaire</th>
        <th>Type</th>
        <th>Caractéristiques</th>
        <th>Etat réception</th>
        <th>Etat affectation</th>
    </tr>
</thead>
<tbody>
    <% 
    if (listRessources != null && chef != null) {
        for (RessourceModel ressource : listRessources) {
            if (ressource.getBesoin().getPersonnelAdministration().getCin().equals(chef.getCin())) {
    %>
    <tr>
        <td><%= ressource.getNumero_inventaire() %></td>
        <td><%= ressource.getBesoin().getType() %></td>
        <td>
            <% 
            if (ressource.getBesoin().getType().equals("ordinateur")) {
                OrdinateurModel ordinateur = (OrdinateurModel) ressource.getBesoin();
            %>
            CPU: <%= ordinateur.getCpu() %>, Disque dur: <%= ordinateur.getDisque_dur() %>, Écran: <%= ordinateur.getEcran() %>, RAM: <%= ordinateur.getRam() %>
            <% 
            } else if (ressource.getBesoin().getType().equals("imprimante")) {
                ImprimanteModel imprimante = (ImprimanteModel) ressource.getBesoin();
            %>
            Résolution: <%= imprimante.getResolution() %>, Vitesse: <%= imprimante.getVitesse() %>
            <% 
            }
            %>
        </td>
        <td><%= ressource.getEtat_recep() %></td>
        <td><%= ressource.getEtat_affect() %></td>
        <td class="action-icons"> 
            <input type="hidden" name="ressourceId" id="ressourceId" value="<%= ressource.getIdRes() %>">
            <i class="fas fa-wrench report-icon" title="Signaler Panne" ></i> 
        </td>
    </tr>
    <% 
            }
        }
    }
    %>
</tbody>
</table>
         
<div id="modal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <br>
    <h4>Sélectionner la date de panne</h4>
    <input type="date" id="datePicker">
    <br>
    <button id="confirmButton">Confirmer</button>
  </div>
</div>

<script>
$(document).ready(function(){
    var modal = $("#modal");
    var closeBtn = $(".close");

    $(".report-icon").click(function() {
        var ressourceId = $(this).siblings('#ressourceId').val();
        $.ajax({
            type: "GET",
            url: "/backend/pannes?id=" + ressourceId,
            success: function(data) {
            	 if (data) {
                     var jsonString = JSON.stringify(data);
                     if (data.etat_panne && data.etat_panne === "Non réparée") {
                    	 Swal.fire({
                    	        icon: 'info',
                    	        title: 'En cours de réparation',
                    	        text: 'La ressource est actuellement en panne et en cours de réparation. Veuillez patienter.',
                    	    });
                     }
                     else if (data.etat_panne && data.etat_panne === "Sévère") {
                    	    Swal.fire({
                    	        icon: 'error',
                    	        title: 'Panne sévère signalée',
                    	        text: 'Une panne sévère a été signalée sur cette ressource. Le responsable des ressources a été contacté pour trouver une solution.',
                    	    });
                    	}
                     else{
                    	 modal.css("display", "block");
                     }
                     
                 } else {
                 	modal.css("display", "block");
                 }
            },
            error: function(xhr, status, error) {
            }
        });
    });

    closeBtn.click(function() {
        modal.css("display", "none");
    });

    $("#confirmButton").click(function() {
        var selectedDate = $("#datePicker").val();
        var ressourceId = $("#ressourceId").val();
        alert(ressourceId)
        if (!selectedDate) {
        	modal.css("display", "none");
            Swal.fire({
                icon: 'error',
                title: 'Erreur !',
                text: 'Veuillez sélectionner une date de panne.'
            });
            return;
        }

        var selectedDateObj = new Date(selectedDate);
        var today = new Date();

        if (selectedDateObj >= today) {
        	modal.css("display", "none");
            Swal.fire({
                icon: 'error',
                title: 'Erreur !',
                text: 'La date de panne doit être antérieure à la date d\'aujourd\'hui.'
            });
            return;
        }

        $.ajax({
            type: "POST",
            url: "/signalerPanneChef",
            data: { ressourceId: ressourceId, selectedDate: selectedDate },
            success: function(response) {
                modal.css("display", "none");
                Swal.fire({
                    icon: 'success',
                    title: 'Succès !',
                    text: 'Panne déclarée avec succès !',
                    timer: 1000, 
                    timerProgressBar: true
                });
            },
            error: function(xhr, status, error) {
                Swal.fire({
                    icon: 'error',
                    title: 'Erreur !',
                    text: 'Erreur lors de l\'envoi des données : ' + error
                });
            }
        });
    });
});
</script>  
</body>
</html>
