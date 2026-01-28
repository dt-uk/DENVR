import React, { useState } from 'react';

/**
 * React component displaying SLK6 theorem interactively
 */

const TheoremDisplay = () => {
  const [ringType, setRingType] = useState('noetherian');
  const [moduleRank, setModuleRank] = useState(3);
  const [results, setResults] = useState(null);

  const theoremConditions = [
    {
      id: 1,
      statement: "P is projective",
      latex: "P \\text{ is projective}"
    },
    {
      id: 2,
      statement: "Pₚ is free over Aₚ for every prime ideal p",
      latex: "P_{\\mathfrak{p}} \\text{ is free over } A_{\\mathfrak{p}} \\text{ for all primes } \\mathfrak{p}"
    },
    {
      id: 3,
      statement: "Pₘ is free over Aₘ for every maximal ideal m",
      latex: "P_{\\mathfrak{m}} \\text{ is free over } A_{\\mathfrak{m}} \\text{ for all maximals } \\mathfrak{m}"
    }
  ];

  const verifyTheorem = () => {
    // Simplified verification logic
    const isNoetherian = ringType === 'noetherian';
    const isProjective = moduleRank > 0;
    const locallyFree = isNoetherian && moduleRank > 0;

    const verificationResults = {
      condition1: isProjective,
      condition2: locallyFree,
      condition3: locallyFree,
      equivalent: isProjective === locallyFree,
      timestamp: new Date().toISOString()
    };

    setResults(verificationResults);
  };

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', padding: '20px' }}>
      <h1>SLK6: Noetherian Module Theorem</h1>
      
      <div style={{ 
        backgroundColor: '#f8f9fa', 
        padding: '20px', 
        borderRadius: '8px',
        marginBottom: '20px'
      }}>
        <h2>Theorem Statement</h2>
        <p>Let <strong>A</strong> be a Noetherian ring, and <strong>P</strong> a finitely generated A-module.</p>
        
        <div style={{ marginLeft: '20px' }}>
          {theoremConditions.map(cond => (
            <div key={cond.id} style={{ margin: '10px 0', padding: '10px', borderLeft: '3px solid #007bff' }}>
              <strong>({cond.id})</strong> {cond.statement}
            </div>
          ))}
        </div>
        
        <p style={{ fontStyle: 'italic', marginTop: '15px' }}>
          These three conditions are equivalent.
        </p>
      </div>

      <div style={{ 
        display: 'grid', 
        gridTemplateColumns: '1fr 1fr', 
        gap: '20px',
        marginBottom: '20px'
      }}>
        <div>
          <h3>Configure Parameters</h3>
          
          <div style={{ marginBottom: '15px' }}>
            <label>Ring Type: </label>
            <select 
              value={ringType}
              onChange={(e) => setRingType(e.target.value)}
              style={{ padding: '5px', marginLeft: '10px' }}
            >
              <option value="noetherian">Noetherian</option>
              <option value="non-noetherian">Non-Noetherian</option>
            </select>
          </div>
          
          <div style={{ marginBottom: '15px' }}>
            <label>Module Rank: </label>
            <input 
              type="number" 
              value={moduleRank}
              onChange={(e) => setModuleRank(parseInt(e.target.value))}
              style={{ padding: '5px', marginLeft: '10px', width: '60px' }}
              min="0"
              max="10"
            />
          </div>
          
          <button 
            onClick={verifyTheorem}
            style={{
              padding: '10px 20px',
              backgroundColor: '#007bff',
              color: 'white',
              border: 'none',
              borderRadius: '4px',
              cursor: 'pointer'
            }}
          >
            Verify Theorem
          </button>
        </div>
        
        <div>
          <h3>Mathematical Context</h3>
          <ul>
            <li>Noetherian rings: Commutative rings with ascending chain condition</li>
            <li>Projective modules: Direct summands of free modules</li>
            <li>Localization: Technique to study local properties</li>
            <li>Applications: Algebraic geometry, coding theory, cryptography</li>
          </ul>
        </div>
      </div>

      {results && (
        <div style={{ 
          backgroundColor: '#e7f3ff', 
          padding: '20px', 
          borderRadius: '8px',
          border: '1px solid #b3d7ff'
        }}>
          <h3>Verification Results</h3>
          
          <div style={{ display: 'flex', justifyContent: 'space-around', margin: '20px 0' }}>
            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '24px', fontWeight: 'bold' }}>
                {results.condition1 ? '✓' : '✗'}
              </div>
              <div>Condition 1</div>
            </div>
            
            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '24px', fontWeight: 'bold' }}>
                {results.condition2 ? '✓' : '✗'}
              </div>
              <div>Condition 2</div>
            </div>
            
            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '24px', fontWeight: 'bold' }}>
                {results.condition3 ? '✓' : '✗'}
              </div>
              <div>Condition 3</div>
            </div>
          </div>
          
          {results.equivalent ? (
            <div style={{ 
              padding: '15px', 
              backgroundColor: '#d4edda', 
              borderRadius: '4px',
              color: '#155724'
            }}>
              <strong>✓ Theorem Verified:</strong> All conditions are equivalent as expected for Noetherian rings.
            </div>
          ) : (
            <div style={{ 
              padding: '15px', 
              backgroundColor: '#f8d7da', 
              borderRadius: '4px',
              color: '#721c24'
            }}>
              <strong>✗ Non-equivalence detected:</strong> Expected only for non-Noetherian rings.
            </div>
          )}
          
          <div style={{ marginTop: '10px', fontSize: '12px', color: '#666' }}>
            Verified at: {new Date(results.timestamp).toLocaleString()}
          </div>
        </div>
      )}

      <div style={{ marginTop: '30px', fontSize: '14px', color: '#555' }}>
        <h4>Technical Implementation</h4>
        <p>This demonstration uses simplified logic. Full implementation requires:</p>
        <ul>
          <li>Module homomorphism calculations</li>
          <li>Localization at prime ideals</li>
          <li>Ext functor computations for projectivity</li>
          <li>Nakayama's lemma applications</li>
        </ul>
      </div>
    </div>
  );
};

export default TheoremDisplay;
