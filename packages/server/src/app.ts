import { Operation } from "@usrbinboat/core";
import type { Application, Request, Response } from "express";
import express from "express";

export interface AppProps {
    operation: Operation;
    port: number;
}

type AppOptions = Partial<AppProps> & {
    operation: Operation;
};

export class App {
    public readonly app: Application;
    private readonly port: number;

    private constructor(props: AppProps) {
        this.app = express();
        this.port = props.port;
        this.routes(props.operation);
    }

    private routes(operation: Operation) {
        this.app.get("/", (_: Request, res: Response) => {
            const num1 = Math.floor(Math.random() * 10);
            const num2 = Math.floor(Math.random() * 10);
            if (operation instanceof Operation) {
                const str = operation.stringify(num1, num2);
                res.send(str);
            }
        });
    }

    public start() {
        this.app.listen(this.port, () => {
            console.log(`server started at http://localhost:${this.port}`);
        });
    }

    static create(options: AppOptions): App {
        const props: AppProps = {
            ...options,
            port: options.port || 8080,
        };

        return new App(props);
    }
}
