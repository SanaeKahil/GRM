<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"> 
    <title>Page de connexion</title>
    <!-- Inclure le fichier CSS relatif -->
    <link href="/static/css/LoginInterfaceCSS.css" rel="stylesheet" type="text/css">
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>

    <div class="main-login">
        <div class="login-contain container">
            <div class="left-side">
            
                <div class="text-center">
                    <%-- Utilisation de la syntaxe JSP pour afficher un message d'erreur --%>
                    
                   
                        <div class="text-center">
                            <h4>Espace fournisseur ...! 🌐 🌟</h4>
                        </div>
                  
                </div>
                
                <form action="/loginFournisseurP" method="post" style="margin-top: 15%;">
                    <label class="label-label" for="nomSociete"> <h6> Nom Societe :</h6> </label>
                    <input type="text" name="nomSociete" id="nomSociete" class="input-login" placeholder="Entrez le nom de votre societé..." value="" />
                    
                    <label class="label-label" for="motDePasse"> <h6>Mot de passe :</h6> </label>
                    <input type="password" name="motDePasse" id="motDePasse" class="input-login" placeholder="Entrez votre mot de passe..." value="" onchange="setpassval(this.value);" />
                    
                    <button type="submit" id="sub-butt" class="btn btn" style="margin-right: -32%; background: #008B8B"> Se connecter </button>
                    <button onclick="RetourPageFournisseur();" type="button" id="sub-butt" class="btn btn-danger" style="background: #DC143C"> Retour </button>
                </form> <br/>
                
            </div>  

            <div class="right-side">
                <div class="welcomeimg img-class">
                    <img src="/static/images/logo2.png" id="img-id" alt="" class="w-100" />
                </div> 
            </div>  
        </div> 
    </div>  

    <script>
        function RetourPageFournisseur() {
            if (window.confirm("Voulez-vous vraiment annuler ?")) {
                location.replace("http://localhost:4040/PagePublique");
            }
        }
        
       
    </script>
   
    
   
  
</body>
</html>
