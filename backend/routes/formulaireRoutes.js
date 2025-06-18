const express = require('express');
const router = express.Router();
const Formulaire = require('../models/Formulaire');

// Route POST
router.post('/', async (req, res) => {
    try {
        const nouveauFormulaire = new Formulaire(req.body);
        await nouveauFormulaire.save();
        res.status(201).json({ message: 'Formulaire enregistré !' });
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

module.exports = router;
