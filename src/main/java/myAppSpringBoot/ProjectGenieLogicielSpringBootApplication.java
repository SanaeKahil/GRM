package myAppSpringBoot;

import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
//@EntityScan("myAppSpringBoot")
public class ProjectGenieLogicielSpringBootApplication implements CommandLineRunner {
	
    @Autowired
    private DataSource dataSource;
    
    @Autowired
    private PasswordEncoder passwordEncoder; // Injectez l'encodeur de mots de passe

	public static void main(String[] args) { 
		SpringApplication.run(ProjectGenieLogicielSpringBootApplication.class, args);
	}
	
    public void run(String... args) throws Exception {
        System.err.println("\nTest de la connexion a la base de donnees...");

        try {
            Connection connection = dataSource.getConnection();
            System.err.println("Connexion a la base de donnees etablie.");  
            connection.close();
        } catch (SQLException e) {
            System.err.println("Impossible d'etablir une connexion a la base de donnees : " + e.getMessage());
        }
        
       /* 
       // Encodez votre mot de passe avec BCryptPasswordEncoder
        String motDePasseClair = "1234";
        String motDePasseEncode = passwordEncoder.encode(motDePasseClair);  
        System.out.println("Mot de passe clair : " + motDePasseClair);
        System.out.println("Mot de passe encodé : " + motDePasseEncode); */
    }
    
    
	@Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer () {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**").allowedOrigins("*");
			}
		};
	}

}
