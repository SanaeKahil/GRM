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
    
    <!-- SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>

    <div class="main-login">
        <div class="login-contain container">
            <div class="left-side">
            
                <div class="text-center">
                    <%-- Utilisation de la syntaxe JSP pour afficher un message d'erreur --%>
                    <c:if test="${not empty errorMessage}">
                        <div style="color: red; font-size: 18px;">
                            <h4>${errorMessage}</h4>
                        </div>
                    </c:if>
                   
                    <c:if test="${empty errorMessage}">
                        <div class="text-center">
                            <h4>Welcome sur notre application ...! 🌐 🚀 🌟</h4>
                        </div>
                    </c:if>
                </div>
                
                <form id="loginForm" action="/loginForm" method="post" style="margin-top: 15%;" onsubmit="return validateForm()">
                    <label class="label-label" for="email"> <h6> Email :</h6> </label>
                    <input type="email" name="emailForm" id="emailForm" class="input-login" placeholder="Entrez votre email..." value="" />
                    
                    <label class="label-label" for="password"> <h6>Password :</h6> </label>
                    <input type="password" name="passwordForm" id="passwordForm" class="input-login" placeholder="Entrez votre mot de passe..." value="" />
                    
                    <button type="submit" id="sub-butt" class="btn btn" style="margin-right: -32%; background: #008B8B"> Vérifier </button>
                    <button onclick="RetourPageUser();" type="button" id="sub-butt" class="btn btn-danger" style="background: #DC143C"> Retour </button>
                </form> <br/>
                </form> <br/>
                                
                <div class="text-center mt-3">
                    <h6 style="cursor:pointer;"> <div onclick="ModifierPassword();"> Mot de passe oublié ? </div> </h6>
                </div>
            </div>  <!-- La fin de class="left-side"  -->

            <div class="right-side">
                <div class="welcomeimg img-class" style="width: 115%; height: 100%; margin-bottom: 15%;">
                    <img src="/static/images/logo4.png" id="img-id" alt="" class="w-100" />
                </div> 
            </div>   <!-- La fin de class="right-side"  -->
        </div> <!-- La fin de class="login-contain container"  -->
    </div>  <!-- La fin de class="main-login"  -->

    <script>
        function RetourPageUser() {
            if (window.confirm("Voulez-vous vraiment annuler ?")) {
                location.replace("http://localhost:4040/login");
            }
        }
        
        function ModifierPassword() {
            if (window.confirm("Voulez-vous vraiment modifier le mot de passe ?")) {
                var currentPath = location.pathname;
            }
        }
        
        function validateForm() {
            var email = document.getElementById('emailForm').value;
            var password = document.getElementById('passwordForm').value;
            
            if (email.trim() === '' || password.trim() === '') {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Veuillez remplir tous les champs!',
                });
                return false; // empêche la soumission du formulaire
            }
            return true; // permet la soumission du formulaire
        }
    </script>
  
</body>
</html>