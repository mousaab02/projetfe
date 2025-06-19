const express = require('express');
const router = express.Router();
const Formulaire = require('../models/Formulaire');

// Route POST avec validation
router.post('/', async (req, res) => {
    const { nom, email, message } = req.body;

    if (!nom || !email) {
        return res.status(400).json({ message: 'Nom et email sont obligatoires' });
    }

    try {
        // Simuler une erreur volontaire pour test
        if (req.body.nom === 'error') {
            throw new Error('Erreur test volontaire');
        }

        const nouveauFormulaire = new Formulaire({ nom, email, message });
        await nouveauFormulaire.save();
        res.status(201).json({ message: 'Formulaire enregistré !' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
