import React, { useState } from 'react';
import axios from 'axios';
import './NullstellensatzSolver.css';

const NullstellensatzSolver = () => {
    const [f, setF] = useState('x^2 + y^2 - 1');
    const [fList, setFList] = useState(['x - 1', 'y']);
    const [variables, setVariables] = useState(['x', 'y']);
    const [result, setResult] = useState(null);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState('');

    const handleSolve = async () => {
        setLoading(true);
        setError('');
        
        try {
            const response = await axios.post('/api/solve', {
                f,
                fList,
                variables
            });
            
            setResult(response.data);
        } catch (err) {
            setError(err.response?.data?.message || 'Failed to solve problem');
            console.error(err);
        } finally {
            setLoading(false);
        }
    };

    const handleGenerateTest = async () => {
        try {
            const response = await axios.get('/api/test');
            const { f: newF, fList: newFList, variables: newVars } = response.data.testCase;
            
            setF(newF);
            setFList(newFList);
            setVariables(newVars);
            setResult(null);
            setError('');
        } catch (err) {
            setError('Failed to generate test case');
        }
    };

    const addPolynomial = () => {
        setFList([...fList, '']);
    };

    const updatePolynomial = (index, value) => {
        const newFList = [...fList];
        newFList[index] = value;
        setFList(newFList);
    };

    return (
        <div className="solver-container">
            <h1>Hilbert's Nullstellensatz Solver</h1>
            <p className="description">
                Check if polynomial f is in the radical of ideal (f1,...,fr)
            </p>

            <div className="input-section">
                <div className="input-group">
                    <label>Polynomial f:</label>
                    <input
                        type="text"
                        value={f}
                        onChange={(e) => setF(e.target.value)}
                        placeholder="e.g., x^2 + y^2 - 1"
                    />
                </div>

                <div className="input-group">
                    <label>Variables (comma-separated):</label>
                    <input
                        type="text"
                        value={variables.join(', ')}
                        onChange={(e) => setVariables(e.target.value.split(',').map(v => v.trim()))}
                        placeholder="e.g., x, y, z"
                    />
                </div>

                <div className="input-group">
                    <label>Ideal Generators f1,...,fr:</label>
                    {fList.map((poly, index) => (
                        <div key={index} className="polynomial-input">
                            <input
                                type="text"
                                value={poly}
                                onChange={(e) => updatePolynomial(index, e.target.value)}
                                placeholder={`f${index + 1} (e.g., x - 1)`}
                            />
                            {index > 0 && (
                                <button
                                    className="remove-btn"
                                    onClick={() => setFList(fList.filter((_, i) => i !== index))}
                                >
                                    Remove
                                </button>
                            )}
                        </div>
                    ))}
                    <button className="add-btn" onClick={addPolynomial}>
                        + Add Polynomial
                    </button>
                </div>

                <div className="button-group">
                    <button onClick={handleSolve} disabled={loading}>
                        {loading ? 'Solving...' : 'Solve Nullstellensatz'}
                    </button>
                    <button onClick={handleGenerateTest} className="secondary-btn">
                        Generate Test Case
                    </button>
                </div>
            </div>

            {error && (
                <div className="error-message">
                    Error: {error}
                </div>
            )}

            {result && (
                <div className="result-section">
                    <h2>Solution</h2>
                    
                    <div className="problem-statement">
                        <h3>Problem:</h3>
                        <p><strong>f</strong> = {result.problem.f}</p>
                        <p><strong>Ideal generators:</strong></p>
                        <ul>
                            {result.problem.fList.map((poly, idx) => (
                                <li key={idx}>f{idx + 1} = {poly}</li>
                            ))}
                        </ul>
                        <p><strong>Variables:</strong> {result.problem.variables.join(', ')}</p>
                    </div>

                    <div className="solution">
                        <h3>Solution:</h3>
                        <div className="solution-card">
                            <p><strong>Is f in √(f1,...,fr)?</strong> {result.solution.isInRadical ? 'Yes' : 'No'}</p>
                            {result.solution.isInRadical && (
                                <>
                                    <p><strong>Power N:</strong> {result.solution.N}</p>
                                    <p><strong>Coefficients:</strong> {result.solution.coefficients.join(', ')}</p>
                                </>
                            )}
                            <p><strong>Explanation:</strong> {result.solution.explanation}</p>
                        </div>
                    </div>

                    <div className="theorem-info">
                        <h3>Hilbert's Nullstellensatz:</h3>
                        <p>
                            If K is algebraically closed, then for any polynomials f, f1,...,fr,
                            f vanishes on all common zeros of f1,...,fr if and only if
                            f^N ∈ (f1,...,fr) for some N ≥ 1.
                        </p>
                        <p>
                            That is: ∃ N and g1,...,gr such that f^N = g1f1 + ... + grfr
                        </p>
                    </div>
                </div>
            )}
        </div>
    );
};

export default NullstellensatzSolver;
