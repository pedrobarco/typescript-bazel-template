import { Operation } from "@usrbinboat/core";
import request from "supertest";

import { App } from "./app";

describe("app", () => {
    const operation = new (class extends Operation {
        exec() {
            return 0;
        }
    })();
    const app = App.create({ operation }).app;

    describe("get /", () => {
        it("returns 200", async () => {
            expect.assertions(1);

            const res = await request(app).get("/");

            expect(res.statusCode).toBe(200);
        });
    });
});
