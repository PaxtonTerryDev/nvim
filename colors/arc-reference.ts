// arc-reference.ts - Open this file to see your colorscheme highlights
// Keep it split to the side while you work on your theme

// ============================================
// SYNTAX GROUPS
// ============================================

// Comment - single line comment
/* Comment - multi-line comment */
/** SpecialComment - documentation comment */

const myString: string = "String highlight";
const myNumber: number = 42;
const myBoolean: boolean = true;
const myFloat: number = 3.14;

// ============================================
// KEYWORDS & OPERATORS
// ============================================

function myFunction() {
  if (true) {
    return "Keyword, Conditional, Statement";
  } else {
    throw new Error("Exception");
  }
}

const myArrow = () => "Function";

for (let i = 0; i < 10; i++) {
  // Repeat, Operator
  continue;
}

while (false) {
  break;
}

// ============================================
// TYPES & CLASSES
// ============================================

type MyType = string | number;
interface MyInterface {
  prop: string;
}

class MyClass {
  private member: string;

  constructor(value: string) {
    this.member = value;
  }

  public method(): void {
    // Type, StorageClass, Structure
  }
}

enum MyEnum {
  First,
  Second,
}

// ============================================
// TREESITTER SPECIFIC
// ============================================

// @variable
const myVariable = "value";

// @variable.builtin
const thisKeyword = this;

// @variable.parameter
function withParams(param1: string, param2: number) {
  return param1;
}

// @variable.member
const obj = {
  memberProperty: "value",
  nestedObj: {
    deepProp: 123
  }
};

// @constant
const MY_CONSTANT = "CONSTANT";

// @function and @function.call
myFunction();
console.log("built-in function call");

// @keyword.function
async function asyncFunc() {
  await Promise.resolve();
}

// @keyword.import
import { something } from './module';
export default MyClass;

// @keyword.type
type StringType = string;

// @keyword.return
function returner() {
  return true;
}

// @keyword.conditional
const ternary = true ? "yes" : "no";

// @boolean
const trueValue = true;
const falseValue = false;

// @punctuation.delimiter
const array = [1, 2, 3];

// @punctuation.bracket
const brackets = { key: "value" };
const parens = (1 + 2);

// @operator
const sum = 1 + 2 - 3 * 4 / 5;
const comparison = a === b && c !== d;

// @string and variants
const normalString = "normal string";
const templateString = `template ${myVariable}`;
const regexString = /pattern/g;
const escapedString = "with\nnewline";

// @comment.warning
// WARNING: This is a warning comment
// TODO: This is a todo comment
// NOTE: This is a note comment

// @comment.documentation
/**
 * Documentation comment
 * @param value - parameter description
 * @returns something
 */
function documented(value: string): string {
  return value;
}

// @type.builtin
const str: string = "";
const num: number = 0;
const bool: boolean = false;

// @property
interface Props {
  firstName: string;
  lastName: string;
}

// @constructor
const instance = new MyClass("value");

// @tag (JSX/TSX)
const element = <div className="test" > Content </div>;

// ============================================
// SPECIAL CASES
// ============================================

// Label
labelName: {
  break labelName;
}

// Macro / Preprocessor (less common in TS, but shown for completeness)
// #define MACRO_NAME

// Debug (debugger statement)
debugger;

// Error - intentionally wrong syntax to show error highlight
// const broken = ;

// ============================================
// MARKUP (for markdown/documentation)
// ============================================

/**
 * # Heading 1
 * ## Heading 2
 * 
 * **Bold text** and *italic text*
 * 
 * [Link text](https://example.com)
 * 
 * `inline code`
 * 
 * - List item
 * - Another item
 */
