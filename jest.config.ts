import type { Config } from "@jest/types";

const config: Config.InitialOptions = {
    preset: "ts-jest",
    moduleNameMapper: {
        "^@usrbinboat/(.*)$": "<rootDir>/packages/$1",
    },
};
export default config;
