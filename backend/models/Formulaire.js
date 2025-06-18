const mongoose = require('mongoose');

const formulaireSchema = new mongoose.Schema({
    nom: String,
    email: String,
    message: String,
}, { timestamps: true });

module.exports = mongoose.model('Formulaire', formulaireSchema);
