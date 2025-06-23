// testSonar.js - fichier avec des erreurs exprès pour test SonarCloud

// ❌ Code Smell: variable jamais utilisée
const unusedVariable = 123;

// ❌ Bug: division par zéro
function divide(a, b) {
  return a / b;
}
const result = divide(5, 0);

// ❌ Security Hotspot: utilisation de eval
const userInput = "2 + 2";
eval(userInput); // NE FAIS JAMAIS ÇA EN PROD !

// ❌ Code Smell: duplication
console.log("Dupliqué");
console.log("Dupliqué");
console.log("Dupliqué");
