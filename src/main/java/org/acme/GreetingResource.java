package org.acme;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/hello")
public class GreetingResource {

    @ConfigProperty(name= "app.dev.name")
    String devName;

    @ConfigProperty(name = "app.project.name")
    String projectName;

    @ConfigProperty(name = "company")
    String company;

    @ConfigProperty(name = "secret.token")
    String secretToken;

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String hello() {
        return "Hello RESTEasy " + devName + " " + projectName + " " + company + " " + secretToken;
    }
}
