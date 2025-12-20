# Custom Snippets for blink.cmp  

This directory contains custom snippets that work with blink.cmp. 
Snippets are defined in JSON format (VSCode-style).

## To Add More Languages

To add snippets for another language:

1. **Create a JSON file** for your language (e.g., `javascript.json`, `python.json`)
2. **Add it to `package.json`:**

   ```json
   {
     "name": "custom-snippets",
     "contributes": {
       "snippets": [
         { "language": "java", "path": "./java.json" },
         { "language": "javascript", "path": "./javascript.json" }
       ]
     }
   }
   ```

3. **Define your snippets in the JSON file:**
   ```json
   {
     "Console Log": {
       "prefix": "cl",
       "body": [
         "console.log($1);"
       ],
       "description": "Console log statement"
     }
   }
   ```

## Snippet Syntax Guide

### Basic Structure

```json
{
  "Snippet Name": {
    "prefix": "trigger",
    "body": [
      "line 1",
      "line 2"
    ],
    "description": "What this snippet does"
  }
}
```

### Placeholders
- `$1`, `$2`, `$3` - Tab stops (jump points)
- `$0` - Final cursor position
- `${1:default}` - Tab stop with default text

### Example with Placeholders
```json
{
  "For Loop": {
    "prefix": "for",
    "body": [
      "for (int ${1:i} = 0; ${1:i} < ${2:length}; ${1:i}++) {",
      "\t$0",
      "}"
    ]
  }
}
```

### Variables
You can use regex transformations like:
- `${1/(.)(.*)/\\u$1$2/}` - Capitalize first letter

