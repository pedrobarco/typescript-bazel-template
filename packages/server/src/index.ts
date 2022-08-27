import { Add } from "@usrbinboat/add";

import { App } from "./app";

const app = App.create({
    operation: new Add(),
    port: 8080,
});

app.start();
