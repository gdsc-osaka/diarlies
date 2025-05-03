import globals from "globals";
import pluginJs from "@eslint/js";
import tseslint from "typescript-eslint";
import tseslintparser from "@typescript-eslint/parser";

// const sqlConfig = {
//     plugins: {
//         safeqr
//     },
//     // Prisma 関連
//     '@ts-safeql/check-sql': [
//         'error',
//         {
//             connections: [
//                 {
//                     // The migrations path:
//                     migrationsDir: './prisma/migrations',
//                     targets: [
//                         // This makes `prisma.$queryRaw` and `prisma.$executeRaw` commands linted
//                         {tag: 'prisma.+($queryRaw|$executeRaw)', transform: '{type}[]'},
//                     ],
//                 },
//             ],
//         },
//     ],
// }

// prettier との連携のため
const tsParser = {
    // env: {
    //     // "es2021": true,
    //     node: true,
    // },
    languageOptions: {
        parser: tseslintparser,
        parserOptions: {
            sourceType: "module",
            project: "tsconfig.eslint.json"
        },
    },
    plugins: {
        tseslint
    },
}

const myRules = {
    rules: {
        // eqeqeq: 'error', // ===にしないとエラー
        // 'no-console': 'warn', // console.xxxを使うと警告
        // 'no-warning-comments': [
        //     // 対象のコメントを書くと警告
        //     'warn',
        //     {terms: ['todo', 'fixme', 'memo'], location: 'anywhere'},
        // ],
        // 'max-statements': ['warn', 30], // 宣言した関数や変数の上限値
        // 'max-lines': ['warn', 500], // 1ファイルの最大行数
        // 'max-lines-per-function': ['warn', {max: 30, skipBlankLines: true}], // 関数内の行数が30行超えると警告
        // 'max-depth': ['warn', 3], // ネストが3を超えると警告
        // complexity: ['warn', 5], // 複雑度が5を超えると警告
        // indent: ['error', 4], // 4スペース以外のインデントはエラー
        // '@typescript-eslint/quotes': ['error', 'single'],
        // '@typescript-eslint/naming-convention': [
        //     'warn',
        //     {selector: 'variableLike', format: ['camelCase']},
        //     {selector: 'method', format: ['camelCase']},
        //     {selector: 'typeLike', format: ['PascalCase']},
        //     {selector: 'parameter', format: ['camelCase']},
        // ],
        // '@typescript-eslint/no-explicit-any': ['error'],
        // FIXME: _ が無視されない
        // '@typescript-eslint/no-unused-vars': [
        //     'warn',
        //     {
        //         "argsIgnorePattern": "^_",
        //         "varsIgnorePattern": "^_",
        //         "caughtErrorsIgnorePattern": "^_",
        //         "destructuredArrayIgnorePattern": "^_"
        //     }
        // ],
        // '@typescript-eslint/no-require-imports': ['error'],
        // '@typescript-eslint/ban-types': [
        //     "error",
        //     {
        //         "extendDefaults": true,
        //         "types": {
        //             "{}": false
        //         }
        //     }
        // ],
        '@typescript-eslint/no-namespace': ['off'],
        'linebreak-style': ['error', 'unix'],
    }
};

export default [
    {
        ignores: [
            'src/grpc/**/*.{ts,js}',
        ]
    },
    {languageOptions: {globals: globals.node}},
    // tsParser,
    // sqlConfig,
    pluginJs.configs.recommended,
    ...tseslint.configs.recommended,
    myRules,
];
