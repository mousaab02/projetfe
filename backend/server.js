const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bodyParser = require('body-parser');
const formulaireRoutes = require('./routes/formulaireRoutes');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(express.static('public'));

// MongoDB connection
mongoose.connect('mongodb+srv://moulaa22:Tetouan1234567@cluster0.ijhr3kn.mongodb.net/formulairedb', {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(() => console.log('MongoDB connecté'))
  .catch(err => console.error(err));

// Routes
app.use('/api/formulaire', formulaireRoutes);

// Lancement du serveur
app.listen(PORT, () => {
    console.log(`Serveur lancé sur http://127.0.0.1:${PORT}`);
});
