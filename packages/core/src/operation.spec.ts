import { Operation } from "./operation";

describe("operation", () => {
    it("prints the operation output", () => {
        expect.assertions(1);

        const op = new (class extends Operation {
            exec() {
                return 0;
            }
        })();

        const msg = op.stringify(1, 2);

        expect(msg).toBe(`1 noop 2 = 0`);
    });
});
