import {Hono} from "hono";
import {openAPISpecs} from "hono-openapi";
import users from "./routes/users";

const app = new Hono();

app.route("/users", users);

app.get("/openapi", openAPISpecs(app, {
    documentation: {
        info: {
            title: "Hono API",
            version: "1.0.0",
            description: "Greeting API",
        },
        servers: [
            {url: "http://localhost:3000", description: "Local Server"},
            {
                url: "https://diarlies.harineko0927.workers.dev",
                description: "Production Server",
            },
        ],
        components: {
            securitySchemes: {
                bearerAuth: {
                    type: "http",
                    scheme: "Bearer",
                    bearerFormat: "JWT",
                },
            },
        },
    }
}));

export default app;
