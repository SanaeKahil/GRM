<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <!-- ======= Styles ====== -->
    <link rel="stylesheet" href="/static/css/style.css">
</head>

<body>

<!-- =============== Navigation ================ -->
    <div class="containerCSS">
        <div class="navigationCSS">
            <ul>
                <li>
                    <div>
                        <span class="icon">
                            <ion-icon name="file-tray-stacked-outline" style="opacity: 0.5;"></ion-icon>
                        </span>
                        <span class="title" style="opacity: 0.5;">Resource</span>
                    </div>
                </li>

                <li style="cursor: pointer;">
                    <div id="besoinsButton">
                        <span class="icon">
                            <ion-icon name="list-outline"></ion-icon>
                        </span>
                        <span class="title">Besoins</span>
                    </div>
                </li>

                <li style="cursor: pointer;">
                    <div id="ressourcesButton">
                        <span class="icon">
                            <ion-icon name="folder-open-outline"></ion-icon>
                        </span>
                        <span class="title">Ressources</span>
                    </div>
                </li>

                <li style="cursor: pointer;">
                    <div id="messagesButton">
                        <span class="icon">
                            <ion-icon name="chatbubble-outline"></ion-icon>
                        </span>
                        <span class="title">Messages</span>
                    </div>
                </li>

                <li style="cursor: pointer;">
                    <div id="profilButton">
                        <span class="icon">
                            <ion-icon name="person-circle-outline"></ion-icon>
                        </span>
                        <span class="title">Profil</span>
                    </div>
                </li>

                <li style="cursor: pointer;">
                    <div>
                        <span class="icon">
                            <ion-icon name="lock-closed-outline"></ion-icon>
                        </span>
                        <span class="title">Password</span>
                    </div>
                </li>

                <li style="cursor: pointer;">
                    <div id="signOutButton">
                        <span class="icon">
                            <ion-icon name="log-out-outline"></ion-icon>
                        </span>
                        <span class="title">Sign Out</span>
                    </div>
                </li>
            </ul>
        </div>
    </div>
<!-- =============== fin Navigation ================ -->

<!-- ====== ionicons ======= -->
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <!-- Assurez-vous d'inclure la bibliothèque SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<script>  
document.getElementById('signOutButton').addEventListener('click', function() {
    // Afficher la boîte de dialogue de confirmation avec SweetAlert
    Swal.fire({
        title: 'Confirmation',
        text: 'Voulez-vous vraiment vous déconnecter ?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Oui',
        cancelButtonText: 'Non'
    }).then((result) => {
        // Si l'utilisateur clique sur "Oui", effectuer la déconnexion
        if (result.isConfirmed) {
            fetch('/logout', {
                method: 'POST' // Vous pouvez utiliser GET ou POST selon votre configuration
            })
            .then(response => {
                // Rediriger l'utilisateur vers la page de connexion après la déconnexion
                window.location.replace('/login');
               //window.location.href = '/login';
            })
            .catch(error => {
                console.error('Erreur lors de la déconnexion :', error);
            });
        }
    });
});
</script>


</body>
</html>