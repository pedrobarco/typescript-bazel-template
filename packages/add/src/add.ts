import { Operation } from "@usrbinboat/core";

export class Add extends Operation {
    sym = "+";
    protected exec(a: number, b: number): number {
        return a + b;
    }
}
