const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bodyParser = require('body-parser');
const formulaireRoutes = require('./routes/formulaireRoutes');

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use(express.static('public'));

mongoose.connect('mongodb+srv://moulaa22:Tetouan1234567@cluster0.ijhr3kn.mongodb.net/formulairedb', {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => console.log('MongoDB connecté pour les tests'))
  .catch(err => console.error(err));

app.use('/api/formulaire', formulaireRoutes);

module.exports = app;
