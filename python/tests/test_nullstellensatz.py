"""
Tests for Nullstellensatz solver
"""

import unittest
import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '../src'))

from nullstellensatz import NullstellensatzSolver


class TestNullstellensatzSolver(unittest.TestCase):
    """Test cases for Nullstellensatz solver"""
    
    def setUp(self):
        """Set up test fixtures"""
        self.solver = NullstellensatzSolver()
    
    def test_parse_polynomials(self):
        """Test polynomial parsing"""
        polys = ["x^2 + y^2 - 1", "x - 1"]
        vars = ["x", "y"]
        
        parsed = self.solver.parse_polynomials(polys, vars)
        
        self.assertEqual(len(parsed), 2)
        self.assertEqual(str(parsed[0]), "Poly(x**2 + y**2 - 1, x, y, domain='QQ')")
    
    def test_simple_case(self):
        """Test simple case where f is in radical"""
        f = "x^2 - 1"
        f_list = ["x - 1"]
        vars = ["x"]
        
        result = self.solver.solve_problem(f, f_list, vars)
        
        self.assertTrue(result["is_in_radical"])
        self.assertIsNotNone(result["N"])
        self.assertIsNotNone(result["coefficients"])
    
    def test_complex_case(self):
        """Test more complex case"""
        f = "x^2*y + y^3"
        f_list = ["x^2 + y^2", "x*y - 1"]
        vars = ["x", "y"]
        
        result = self.solver.solve_problem(f, f_list, vars)
        
        # Just ensure it runs without error
        self.assertIn("is_in_radical", result)
    
    def test_example_from_problem(self):
        """Test example similar to problem statement"""
        f = "x^2 + y^2 - z^2"
        f_list = ["x - y", "y - z", "z - x"]
        vars = ["x", "y", "z"]
        
        result = self.solver.solve_problem(f, f_list, vars)
        
        print(f"\nTest Result: {result}")
        self.assertTrue(isinstance(result, dict))


def run_tests():
    """Run all tests"""
    suite = unittest.TestLoader().loadTestsFromTestCase(TestNullstellensatzSolver)
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)
    
    return result.wasSuccessful()


if __name__ == "__main__":
    success = run_tests()
    sys.exit(0 if success else 1)
