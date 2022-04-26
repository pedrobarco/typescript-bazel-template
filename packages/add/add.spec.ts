import { Add } from "./add";

describe("add", () => {
    it("adds two numbers", () => {
        expect.assertions(1);

        const add = new Add();
        const str = add.stringify(1, 2);

        expect(str).toBe("1 + 2 = 3");
    });
});
