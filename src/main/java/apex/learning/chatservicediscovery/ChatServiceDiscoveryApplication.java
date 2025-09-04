package apex.learning.chatservicediscovery;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@EnableEurekaServer
@SpringBootApplication
public class ChatServiceDiscoveryApplication {

    public static void main(String[] args) {
        SpringApplication.run(ChatServiceDiscoveryApplication.class, args);
    }

}
