import React, { useState } from 'react';

export default function WeatherOutfitApp() {
  const [temperature, setTemperature] = useState(18);
  const [location, setLocation] = useState("Warszawa");
  const [description, setDescription] = useState("Bezchmurnie");
  
  // Określanie zalecanego stroju na podstawie temperatury
  const getOutfitRecommendation = (temperature) => {
    if (temperature >= 30) {
      return {
        outfit: 'Bardzo lekki ubiór',
        items: [
          'Lekka koszulka/top',
          'Krótkie spodenki/spódnica',
          'Sandały/klapki',
          'Kapelusz przeciwsłoneczny',
          'Okulary przeciwsłoneczne',
          'Krem z filtrem UV'
        ],
        icon: '☀️'
      };
    } else if (temperature >= 20) {
      return {
        outfit: 'Lekki ubiór',
        items: [
          'Koszulka z krótkim rękawem',
          'Lekkie spodnie/spódnica',
          'Lekkie buty',
          'Okulary przeciwsłoneczne'
        ],
        icon: '🌤️'
      };
    } else if (temperature >= 15) {
      return {
        outfit: 'Średnio ciepły ubiór',
        items: [
          'Koszulka z długim rękawem',
          'Lekki sweter',
          'Spodnie',
          'Lekka kurtka/bluza'
        ],
        icon: '⛅'
      };
    } else if (temperature >= 10) {
      return {
        outfit: 'Ciepły ubiór',
        items: [
          'Sweter',
          'Spodnie',
          'Kurtka przejściowa',
          'Szalik',
          'Zamknięte buty'
        ],
        icon: '🌥️'
      };
    } else if (temperature >= 0) {
      return {
        outfit: 'Bardzo ciepły ubiór',
        items: [
          'Ciepły sweter',
          'Ciepła kurtka',
          'Spodnie/legginsy ocieplane',
          'Czapka',
          'Szalik',
          'Rękawiczki',
          'Ciepłe buty'
        ],
        icon: '❄️'
      };
    } else {
      return {
        outfit: 'Zimowy ubiór',
        items: [
          'Termiczna bielizna',
          'Grube swetry (warstwy)',
          'Kurtka zimowa',
          'Ciepłe spodnie',
          'Ciepła czapka',
          'Grube rękawiczki',
          'Szalik',
          'Buty zimowe'
        ],
        icon: '🥶'
      };
    }
  };

  // Określenie koloru tła na podstawie temperatury
  const getBackgroundColor = (temperature) => {
    if (temperature >= 30) return '#FF5733'; // Czerwony (gorąco)
    if (temperature >= 20) return '#FFC300'; // Żółty (ciepło)
    if (temperature >= 15) return '#DAF7A6'; // Jasnozielony (przyjemnie)
    if (temperature >= 10) return '#82E0AA'; // Zielony (umiarkowanie)
    if (temperature >= 0) return '#85C1E9';  // Niebieski (chłodno)
    return '#D6EAF8';                        // Jasnoniebieski (zimno)
  };

  const recommendation = getOutfitRecommendation(temperature);
  const backgroundColor = getBackgroundColor(temperature);

  const changeTemperature = (value) => {
    let newTemp = temperature + value;
    // Limit temperature between -20 and 40
    if (newTemp < -20) newTemp = -20;
    if (newTemp > 40) newTemp = 40;
    setTemperature(newTemp);
  };

  // Elementy UI
  return (
    <div className="flex flex-col h-full w-full bg-gray-100">
      {/* Header */}
      <div className="bg-blue-500 p-4 text-center">
        <h1 className="text-2xl font-bold text-white mt-4">PogodoWear</h1>
        <p className="text-white mb-2">Dopasuj ubiór do temperatury</p>
      </div>
      
      {/* Weather Content */}
      <div className="p-4 flex-1 overflow-auto">
        <div 
          className="rounded-lg p-6 shadow-md mb-4"
          style={{ backgroundColor }}
        >
          <div className="text-center mb-4">
            <h2 className="text-xl font-bold text-gray-800">{location}</h2>
            <div className="flex flex-col items-center mt-2">
              <div className="flex items-center">
                <button 
                  onClick={() => changeTemperature(-1)}
                  className="bg-white text-gray-800 font-bold rounded-l p-2 shadow"
                >
                  -
                </button>
                <span className="text-4xl font-bold mx-4 text-gray-800">{temperature}°C</span>
                <button 
                  onClick={() => changeTemperature(1)}
                  className="bg-white text-gray-800 font-bold rounded-r p-2 shadow"
                >
                  +
                </button>
              </div>
              <p className="text-gray-800 mt-2">{description}</p>
            </div>
          </div>
          
          <div className="bg-white bg-opacity-80 rounded-lg p-4 shadow-sm">
            <div className="flex items-center mb-2">
              <span className="text-2xl mr-2">{recommendation.icon}</span>
              <h3 className="text-xl font-bold text-gray-800">{recommendation.outfit}</h3>
            </div>
            
            <div className="mt-2">
              {recommendation.items.map((item, index) => (
                <div key={index} className="flex items-center py-1">
                  <span className="text-blue-500 mr-2">✓</span>
                  <span className="text-gray-800">{item}</span>
                </div>
              ))}
            </div>
          </div>
          
          <button 
            className="mt-4 bg-blue-500 text-white rounded-full py-2 px-4 w-full flex justify-center items-center"
            onClick={() => {
              const options = ['Warszawa', 'Kraków', 'Gdańsk', 'Wrocław', 'Poznań'];
              const descriptions = ['Bezchmurnie', 'Pochmurno', 'Lekkie opady', 'Przelotne opady', 'Deszczowo'];
              setLocation(options[Math.floor(Math.random() * options.length)]);
              setDescription(descriptions[Math.floor(Math.random() * descriptions.length)]);
            }}
          >
            <span className="mr-2">↻</span>
            <span>Odśwież dane</span>
          </button>
        </div>
      </div>
    </div>
  );
}