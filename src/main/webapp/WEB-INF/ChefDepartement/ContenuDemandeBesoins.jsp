<%@ page import="java.util.List" %>
<%@ page import="myAppSpringBoot.Models.PersonnelAdministrationModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.core.type.TypeReference" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Demande des Besoins Éducatifs</title>
    <style>

        .container {
                    width: 1000px;
                    background-color: #fff;
                    border-radius: 10px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    padding: 20px;
                    display: flex;
                    flex-direction: column; 
                     } 

        .message-input {
                    width: 100%;
                    height: 200px;
                    border: 1px solid #ccc;
                    border-radius: 5px;
                    padding: 10px;
                    margin-bottom: 10px;
                    resize: none;
                    }

        .inform-button {
                    background-color: #007bff;
                    color: #fff;
                    border: none;
                    border-radius: 5px;
                    padding: 10px 20px;
                    cursor: pointer;
                    font-size: 16px;
                    align-self: flex-end;
                    margin-left: 855px;
                    }

        .inform-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <br><br><br>
   <div class="container">
    <h2>Demande des Besoins Éducatifs</h2>
    <form id="messageForm" action="/envoyer-message" method="post">
        <textarea id="message-input" name="message" class="message-input" placeholder="Entrez votre message ici"></textarea>
        <button type="submit" class="inform-button">Informer</button>
    </form>
   </div>   
    <script>
        document.getElementById("messageForm").onsubmit = function() {
            var message = document.getElementById("message-input").value.trim(); 
            if (message === "") {
                Swal.fire({
                    icon: 'error',
                    title: 'Erreur !',
                    text: 'Veuillez remplir le champ de message.',
                    showConfirmButton: false,
                    timer:1000
                });
                return false;
            }
        };
    </script>
</body>
</html>