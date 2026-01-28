from setuptools import setup, find_packages

setup(
    name="nullstellensatz-solver",
    version="0.1.0",
    description="Hilbert's Nullstellensatz Polynomial Solver",
    author="shellworlds",
    author_email="crm@borelsigma.in",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    install_requires=[
        "sympy>=1.12",
        "numpy>=1.24.0",
        "scipy>=1.10.0",
    ],
    python_requires=">=3.8",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Science/Research",
        "Topic :: Scientific/Engineering :: Mathematics",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
    ],
)
