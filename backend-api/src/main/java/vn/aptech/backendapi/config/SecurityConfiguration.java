package vn.aptech.backendapi.config;

import jakarta.servlet.DispatcherType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import vn.aptech.backendapi.middle.AuthenticationMiddleware;
import vn.aptech.backendapi.repository.UserRepository;
import vn.aptech.backendapi.service.Auth.AuthenticationService;
import vn.aptech.backendapi.ultils.PublicRoutes;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfiguration {
    @Autowired
    private AuthenticationService authenticationService;
    @Autowired
    private AuthenticationMiddleware authenticationMiddleware;
    @Autowired
    private UserRepository userRepository;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // @Autowired
    public void globalConfiguration(AuthenticationManagerBuilder authentication) throws Exception {
        authentication.userDetailsService(authenticationService).passwordEncoder(passwordEncoder());
    }
    @Bean
    @Order(1)
    public SecurityFilterChain api(HttpSecurity http) throws Exception {
        // Khai báo route ở đây
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.POST,"/api/auth/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.GET,"/api/doctor/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.GET,"api/user").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.GET,"/api/slot/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.POST,"/api/slot/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.PUT,"/api/slot/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.DELETE,"/api/slot/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.GET,"/api/department/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.POST,"/api/department/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.PUT,"/api/department/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.DELETE,"/api/department/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.GET,"/api/working/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.POST,"/api/working/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.PUT,"/api/working/**").injectOn(http);
        PublicRoutes.PublicRoutesManager.publicRoutes().add(HttpMethod.DELETE,"/api/working/**").injectOn(http);
        http.csrf(AbstractHttpConfigurer::disable)
                .securityMatcher("/api/**")
                .authorizeHttpRequests(req->req.anyRequest().authenticated())
                .sessionManagement(sess->sess.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .addFilterBefore(authenticationMiddleware, UsernamePasswordAuthenticationFilter.class)
                .cors(configurer -> new CorsConfiguration().applyPermitDefaultValues());
        return http.build();
    }

}
