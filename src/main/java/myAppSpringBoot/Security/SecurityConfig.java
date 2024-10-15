package myAppSpringBoot.Security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    // Configure les règles de sécurité pour les requêtes HTTP
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .authorizeRequests() // Autorise les requêtes
               // .antMatchers("/", "/static/**", "/loginForm", "/interface-enseignant", "/interface-technicien").permitAll() // Autorise l'accès à ces URL sans authentification
                .antMatchers("/**").permitAll()
                .anyRequest().authenticated() // Toutes les autres requêtes nécessitent une authentification
                .and()
            .formLogin() // Configuration du formulaire de login
                .loginPage("/login") // Spécifie la page de login personnalisée
                .permitAll() // Autorise l'accès à la page de login sans authentification
                .and()
            .logout() // Configuration du logout
                .permitAll() // Autorise l'accès à la page de logout sans authentification
	        //.and().httpBasic()
            //.and().formLogin().disable()
            .and().csrf().disable(); // Désactive la protection CSRF fournie par Spring Security
        
    }

    // Définit un bean pour l'encodage des mots de passe
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // Utilise BCrypt pour encoder les mots de passe
    }
}
