\documentclass{article}
\usepackage{geometry}
\geometry{
 a4paper,
 total={180mm,265mm},
 left=5mm,
 top=5mm,
 }
\usepackage{graphicx}
\usepackage{tikz}
\usepackage[normalem]{ulem}
\usepackage{mathrsfs}
\usepackage{float}
\usepackage{mathtools}
\usepackage{amsmath}
\usepackage{bbm}


\begin{document}


$\textbf{Question 1b}:$

$H_0: $ ${\displaystyle \prod_{i=1}^{l}}{\displaystyle \prod_{j=1}^{9}} P_{S_{i}N_{j}}$

$H_1: $ ${\displaystyle \prod_{i=1}^{l}}{\displaystyle \prod_{j=1}^{8}} \alpha_{S_i1} \cdot P_{jS_{ij}S_{ij+1}}$

\bigbreak
Using algebra, partial derivatives, and logarithms:
\bigbreak


Exhaustive for all sites and WLOG

$L_1 = $ ${\displaystyle \prod_{i=1}^{l}} \alpha_A^{\mathbb{1}\{S_{i1}=A\}} \alpha_C^{\mathbb{1}\{S_{i1}=C\}} \alpha_G^{\mathbb{1}\{S_{i1}=G\}} \alpha_T^{\mathbb{1}\{S_{i1}=T\}} 

P_{1AA}^{\mathbb{1}\{S_{i2}=A \cap S_{i1}=A\}} P_{1AC}^{\mathbb{1}\{S_{i2}=C \cap S_{i1}=A\}} P_{1AG}^{\mathbb{1}\{S_{i2}=G \cap S_{i1}=A\}} P_{1AT}^{\mathbb{1}\{S_{i2}=T \cap S_{i1}=A\}} ... P_{1TT}^{\mathbb{1}\{S_{i2}=T \cap S_{i1}=T\}} $

\bigbreak


$\hspace{10mm}$ $l = $ ${\displaystyle \sum_{i=1}^{l}} {\mathbb{1}\{S_{i1}=A\}}ln(\alpha_A) ... {\mathbb{1}\{S_{i2}=A \cap S_{i1}=A\}}ln(P_{1AA}) + {\mathbb{1}\{S_{i2}=C \cap S_{i1}=A\}}ln(P_{1AC}) 

+ ... + {\mathbb{1}\{S_{i9}=T \cap S_{i8}=T\}}ln(P_{8TT}) + \lambda(1-P_{1AA}-P_{1AC} ... ) $

\bigbreak

$\hspace{10mm}$ $\frac{\partial l_0}{ \partial P_{1AA}} = $ ${\displaystyle \sum_{i=1}^{l}}
\frac{\partial }{\partial P_{1AA}} {\mathbb{1}\{S_{i1}=A\}}ln(\alpha_A) ... {\mathbb{1}\{S_{i2}=A \cap S_{i1}=A\}}ln(P_{1AA}) + {\mathbb{1}\{S_{i2}=C \cap S_{i1}=A\}}ln(P_{1AC}) 

+ ... + {\mathbb{1}\{S_{i9}=T \cap S_{i8}=T\}}ln(P_{8TT}) + \lambda(1-P_{1AA}-P_{1AC} ...) $

\bigbreak

$\hspace{10mm}$ ${\displaystyle \sum_{i=1}^{l}} \frac{{\mathbb{1}\{S_{i2}=A \cap S_{i1}=A\}}}{P_{1AA}} - \lambda = 0 $

\bigbreak

$\hspace{10mm}$ ${\displaystyle \sum_{i=1}^{l}} \frac{{\mathbb{1}\{S_{i2}=A \cap S_{i1}=A\}}}{P_{1AA}} = \lambda $

\bigbreak

$\hspace{10mm}$ $\frac{1}{\lambda} {\displaystyle \sum_{i=1}^{l}} {\mathbb{1}\{S_{i2}=A \cap S_{i1}=A\}} = \hat{P}_{1AA} $

\bigbreak

$\hspace{15mm}$ $\frac{K_{2A|A}}{\lambda} = \hat{P}_{1AA}$

\bigbreak

Where $K_{2A|A}, K_{2T|A}, K_{2G|A}$ and $K_{2C|A}$ are the number of occurrences of A, T, C, and G at position 2 given the nucleotide at position 1 is an A.

\bigbreak

Similarly taking partial derivatives for other probabilities for position 2 given position 1 is an A, and setting them equal to zero, results in $ \frac{K_{2C|A}}{\lambda} = \hat{P}_{1AC}, \frac{K_{2G|A}}{\lambda} = \hat{P}_{1AG}, \frac{K_{2T|A}}{\lambda} = \hat{P}_{1AT}$

\bigbreak


\bigbreak

Solving for $\lambda$

\begin{align*}
    \hat{P}_{1AA}+\hat{P}_{1AC}+\hat{P}_{1AT}+\hat{P}_{1AG}&=1\\
    \frac{K_{2A|A}}{\lambda}+\frac{K_{2C|A}}{\lambda}+\frac{K_{2T|A}}{\lambda}+\frac{K_{2G|A}}{\lambda}&=1\\
    {K_{2A|A}} + {K_{2C|A}} + {K_{2G|A}} + {K_{2T|A}} &= \lambda
\end{align*}

Therefore 

\begin{align*}
    \hat{P}_{1AA} &= \frac{K_{2A|A}}{{K_{2A|A}} + {K_{2C|A}} + {K_{2G|A}} + {K_{2T|A}} }
\end{align*}

Similar results can be obtained for the estimated probability at any other site $x \in \{2..9\}$ and for any combination of nucleotides $b,b' \n \{A,T,C, G\}$

\begin{align*}
    \hat{P}_{xbb'} &= \frac{K_{xb'|b}}{{K_{xA|b}} + {K_{xC|b}} + {K_{xG|b}} + {K_{xT|b}} }    
\end{align*}


\bigbreak

$\hspace{10mm}$ $\frac{\partial l_0}{\partial \alpha_A} {\displaystyle \sum_{i=1}^{l}} {\mathbb{1}\{S_{i1}=A\}ln(\alpha_A)}$

\bigbreak

$\hspace{10mm}$ ${\displaystyle \sum_{i=1}^{l}} \frac{{\mathbb{1}\{S_{i1}=A\}}}{\alpha_A} - \lambda = 0$

\bigbreak

$\hspace{10mm}$ ${\displaystyle \sum_{i=1}^{l}} \frac{{\mathbb{1}\{S_{i1}=A\}}}{\alpha_A} = \lambda $

\bigbreak

$\hspace{10mm}$ $ \frac{1}{\lambda}{\displaystyle \sum_{i=1}^{l}} {\mathbb{1}\{S_{i1}=A\}} = {\hat{\alpha}_A} $

\bigbreak

$\hspace{15mm}$ $\frac{K_{\alpha_A}}{\lambda} = {\hat{\alpha}_A}, \frac{K_{\alpha_C}}{\lambda} = {\hat{\alpha}_C}, \frac{K_{\alpha_G}}{\lambda} = {\hat{\alpha}_G}, \frac{K_{\alpha_T}}{\lambda} = {\hat{\alpha}_T} $

\bigbreak
$\hspace{15mm}$ ${K_{\alpha_A}} + {K_{\alpha_C}} + {K_{\alpha_G}} + {K_{\alpha_T}} = \lambda $

\bigbreak
\bigbreak

$L_0 = $ ${\displaystyle \prod_{i=1}^{l}}{\displaystyle \prod_{j=1}^{9}} P_{iS_{ij}}^{\mathbb{1}\{S_{ij} = A\}} ... P_{iS_{ij}}^{\mathbb{1}\{S_{ij} = G\}}$

\bigbreak

$\hspace{10mm}$ $l = {\displaystyle \sum_{i=1}^{l}}{\displaystyle \sum_{j=1}^{9}} {\mathbb{1}\{S_{ij} = A\}}ln(P_{iS_{ij}})
+ ... + {\mathbb{1}\{S_{ij} = G\}}ln(P_{iS_{ij}}) + \lambda(1-P_{1A} ... P_{1T})$

\bigbreak

$\hspace{10mm}$ $\frac{\partial l_1}{\partial p_{1A}} = {\displaystyle \sum_{i=1}^{l}} \frac{{\mathbb{1}\{S_{i1}=A\}}}{P_{1A}} - \lambda = 0$

\bigbreak

$\hspace{10mm}$ ${\displaystyle \sum_{i=1}^{l}} \frac{{\mathbb{1}\{S_{i1}=A\}}}{P_{1A}} = \lambda $

\bigbreak

$\hspace{10mm}$ $\frac{1}{\lambda} {\displaystyle \sum_{i=1}^{l}} {\mathbb{1}\{S_{i1}=A\}} = \hat{P}_{1A}$

\bigbreak

$\hspace{15mm}$ $\frac{K_{1A}}{\lambda} = \hat{P}_{1A},\frac{K_{1C}}{\lambda} = \hat{P}_{1C}, \frac{K_{1G}}{\lambda} = \hat{P}_{1G}, \frac{K_{1T}}{\lambda} = \hat{P}_{1T} $

\bigbreak

$\hspace{15mm}$ $\frac{{K_{1A}} + {K_{1C}} + {K_{1G}} + {K_{1T}}}{\lambda} = 1 $

\bigbreak 

$\hspace{15mm}$ $ \lambda = {{K_{1A}} + {K_{1C}} + {K_{1G}} + {K_{1T}}} = l $


\end{document}