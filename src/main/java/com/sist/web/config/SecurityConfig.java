package com.sist.web.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import lombok.RequiredArgsConstructor;

/*
 * 	 보안 설정
 * 
 * 	 요청 = Security FilterChain = 인증 = 인가 = Controller = View
 * 				   |			   |	 |					|
 * 									   권한 체크 			   접근권한 => 메뉴를 제한
 * 								 로그인된 사용자 인지
 * 				  설정 (인증 / 인가)
 * 	 인증
 * 	  = 로그인 / 아이디 , 비밀번호 
 * 		 |
 * 		success => Authentication 객체 생성 => 주요정보를 저장 
 * 							 | 인가
 * 								hasRole() , authenticated()
 * 								permitAll
 * 		fail 
 * 
 *   Client -- Security Filter -- Authentication - Authorization - Controller
 *   			사용자 정의							   |
 *   											   Session/Cookie
 *   												  |		 |
 *   												 일반보안  JWT
 *   				| 일반 로그인 / 카카오 로그인 
 */
@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
   @Bean
   public SecurityFilterChain filterChain(HttpSecurity http)
   throws Exception
   {
	   http
	    .csrf(csrt -> csrt.disable())
	    .authorizeHttpRequests(auth -> auth
	    	.requestMatchers("/","/member/**").permitAll()
	    	.requestMatchers("/admin/**").hasRole("ADMIN")
	    	.anyRequest().permitAll()
	    )
	    .formLogin(form -> form
	    	.loginPage("/member/login")
	    	.loginProcessingUrl("/member/login_process")
	    	.defaultSuccessUrl("/main")
	    	.permitAll()
	    )
	    .logout(logout -> logout
	    	.logoutUrl("/member/logout")
	    	.logoutSuccessUrl("/main")
	    );
	   
	    return http.build();
   }
   @Bean
   public PasswordEncoder passwordEncoder() {
	   return new BCryptPasswordEncoder();
   }
}
