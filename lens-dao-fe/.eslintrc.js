// My usual rules. Investigate why the extension isn't catching them.

module.exports = {
  extends: [
    'airbnb',
  ],
  parser: 'babel-eslint',
  env: {
    browser: true,
    es6: true,
  },
  rules: {
    strict: 0,
    quotes: [2, 'single'],
    'no-else-return': 0,
    'new-cap': [0, { capIsNewExceptions: ['Router'] }],
    'no-console': 0,
    'import/no-unresolved': [0, { caseSensitive: false }],
    'import/extensions': 0,
    'no-unused-vars': ['error', { vars: 'all', args: 'none' }],
    'no-underscore-dangle': 0,
    'arrow-body-style': 0,
    'one-var': ['error', { uninitialized: 'always', initialized: 'never' }],
    'one-var-declaration-per-line': ['error', 'initializations'],
    'max-len': ['error', 350],
    'no-extra-parens': 0,
    'linebreak-style': 0,
    'no-restricted-syntax': [
      0,
      'DebuggerStatement',
    ],
    'no-unused-expressions': 'warn',
    'no-debugger': 'warn',
    'no-alert': 2,
    'global-require': 0,
    'react/jsx-uses-react': 2,
    'react/jsx-uses-vars': 2,
    'react/react-in-jsx-scope': 2,
    'react/prop-types': 0,
    'react/destructuring-assignment': 0,
    'react/jsx-first-prop-new-line': 0,
    'react/jsx-filename-extension': 0,
    'react/jsx-props-no-spreading': 0,
    'jsx-a11y/click-events-have-key-events': 0,
    'jsx-a11y/no-noninteractive-element-interactions': 0,
    'react/jsx-one-expression-per-line': 0,
    'react/no-danger': 0,
    'react-hooks/rules-of-hooks': 'error', // Checks rules of Hooks
    'react-hooks/exhaustive-deps': 'warn', // Checks effect dependencies
  },
  plugins: [
    'react',
    'react-hooks',
  ],
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
      sourceType: 'module',
    },
  },
  settings: {
    'import/resolver': {
      node: {
        extensions: ['.js', '.jsx', '.ts', '.tsx'],
      },
    },
  },
};