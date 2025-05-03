import {Hono} from 'hono'
import {describeRoute, openAPISpecs} from 'hono-openapi'
import {
    resolver,
    validator as vValidator,
} from 'hono-openapi/arktype'
import * as a from 'arktype';

const querySchema = a.type({
    "name?": 'string'
})

const responseSchema = a.type('string');

const app = new Hono()

app.get(
    '/',
    describeRoute({
        description: 'Say hello to the user',
        responses: {
            200: {
                description: 'Successful response',
                content: {
                    'text/plain': {schema: resolver(querySchema)},
                },
            },
        },
    }),
    vValidator('query', responseSchema),
    (c) => {
        const query = c.req.valid('query')
        return c.text(`Hello ${query ?? 'Hono'}!`)
    }
)

app.get(
    '/openapi',
    openAPISpecs(app, {
        documentation: {
            info: {
                title: 'Hono API',
                version: '1.0.0',
                description: 'Greeting API',
            },
            servers: [
                {url: 'http://localhost:3000', description: 'Local Server'},
                {url: 'https://diarlies.harineko0927.workers.dev', description: 'Production Server'},
            ],
        },
    })
)

export default app;
