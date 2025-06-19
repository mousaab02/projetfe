const express = require('express');
const router = express.Router();
const Formulaire = require('../models/Formulaire');

router.post('/', async (req, res) => {
  try {
    const { nom, email, message } = req.body;

    // Validation des champs obligatoires
    if (!nom || !email || nom.trim() === '' || email.trim() === '') {
      return res.status(400).json({ message: 'Nom et email sont obligatoires' });
    }

    // Cas test erreur volontaire
    if (nom === 'error') {
      const err = new Error('Erreur test volontaire');
      err.statusCode = 400;
      throw err;
    }

    const nouveauFormulaire = new Formulaire({ nom, email, message });
    await nouveauFormulaire.save();

    res.status(201).json({ message: 'Formulaire enregistré !' });
  } catch (error) {
    const status = error.statusCode || 500;
    res.status(status).json({ error: error.message });
  }
});

module.exports = router;
