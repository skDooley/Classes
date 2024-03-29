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


$\textbf{Question 3a}:$

%This is where 3a begins

%This is the H_0
\begin{equation}
H_0: 
\sum_{\substack{{b' \in \{A,C,G,T\}\\
                  {b' \neq b}}}} \\
        p_{qbb'} = p_q \forall b 
\end{equation}


\bigbreak

The probability of misreading the nucleotide is the same regardless of what the true base is.

\bigbreak

From office hours 2/27/2019:
\bigbreak
Using algebra, partial derivatives, and logarithms:
\bigbreak
$H_0: 1-p_{qbb'} = p_q \forall q,b$

$Parameters: p_0,p_2,...,p_{93} \in [0,1]$

\bigbreak
$L_0(p_0,p_2,...,p_{93}|Data)$

$\hspace{10mm}$
$=Pr(Data|H_0; p_0,p_2,...,p_{93}, Q_{ijk}=q, B_{ijk}=b_{ijk})$

$\hspace{10mm}$
$={\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} Pr(R_{ijk}=r_{ijk}|H_0; p_0,p_2,...,p_{93},Q_{ijk}=q_{ijk},B_{ijk}=b_{ijk})$

Where: i = individual, j = read, k = filtered site


$\hspace{10mm}$
$={\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} (1-p_{q_{ijk}})^{\mathbb{1}\{B_{ijk}=r_{ijk}\}}(p_{_{qijk}})^{\mathbb{1}\{B_{ijk} \neq r_{ijk}\}}$

To optimize computationally
$={\displaystyle \prod_{q=0}^{93}} (1-p_{q})^{\mathbb\sum_{{i,j,k}}{1}\{B_{ijk}=r_{ijk},Q_{ijk}=q\}} (p_{q})^{\mathbb\sum_{{i,j,k}}{1}\{B_{ijk} \neq r_{ijk},Q_{ijk}=q\}}$


\bigbreak
\bigbreak

%This is where our notation begins
$\hspace{5mm}$ $L_0={\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} (1-p_{q_{ijk}})^{\mathbb{1}\{R_{ijk}=b_{k}\}}(p_{q_{ijk}})^{\mathbb{1}\{R_{k} \neq b_{ijk}\}}$

$\hspace{5mm}$ 
$l_0={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}({\mathbb{1}\{R_{ijk}=b_k\}Ln(1-p_{q_{ijk}})+\mathbb{1}\{R_{ijk} \neq b_k\}Ln(p_{q_{ijk}})})$


$\hspace{5mm}$ 
$l_0={\displaystyle \sum_{q=0}^{93}}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=q\}}({\mathbb{1}\{R_{ijk}=b_k\}Ln(1-p_{q_{ijk}})+\mathbb{1}\{R_{ijk} \neq b_k\}Ln(p_{q_{ijk}})})$


$\hspace{5mm}$ 
$\frac{dl_0}{dP_X}={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}} (\frac{-\mathbb{1}\{R_{ijk}=b_k\}}{1-P_{X_{ijk}}}+\frac{\mathbb{1}\{R_{ijk} \neq b_k\}}{P_{X_{ijk}}}) = 0$

$\hspace{10mm}$ 
$={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{R_{ijk} \neq b_k\}(1-P_{X_{ijk}}) - {\mathbb{1}\{{R_{ijk} = b_k}\}(P_{X_{ijk}})}} = 0$


$\hspace{10mm}$ 
$={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{R_{ijk} \neq b_k\}}-{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{R_{ijk} \neq b_k\}(P_{X_{ijk}}})-{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{R_{ijk}=b_k\}(P_{X_{ijk}}}) = 0$ 


$\hspace{10mm}$ 
$=P_{X_{ijk}}({\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{R_{ijk} \neq b_k\}}+{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{R_{ijk}=b_k\}})={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{R_{ijk} \neq b_k\}}$

%This is the final fraction for the H_0
$\hspace{10mm}$ 
$\hat P{_{X}} = \frac{
{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{R_{ijk} \neq b_k\}}}{{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{R_{ijk} \neq b_k\}}+{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{R_{ijk}=b_k\}}}$

Where: q=x


\bigbreak
\bigbreak


%This is the H_1
$H_1: \sum_{b' \neq b} = 1-p_{qbb'} = p_{qb}$

$Parameters: p_{A1},...,p_{G93} \in [0,1]$

\bigbreak
$L_1(p_{A1},...,p_{G93}|Data)$

$\hspace{10mm}$
$=Pr(Data|H_1; p_{A1},...,p_{G93})$

$\hspace{10mm}$
$={\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} Pr(R_{ijk}=r_{ijk}|H_1; p_{A1},...,p_{G93},Q_{ijk}=q_{ijk},B_{ijk}=b_{ijk})$

Where: i = individual, j = read, k = filtered site

$\hspace{5mm}$
$L_1={\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} (1-p_{b_{k}q_{ijk}})^{\mathbb{1}\{R_{ijk}=b_{k}\}}(p_{b_{k}q_{ijk}})^{\mathbb{1}\{R_{ijk} \neq b_{k}\}}$


$\hspace{5mm}$ 
$l_1={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}({\mathbb{1}\{R_{ijk}=b_k\}Ln(1-p_{b_{k}q_{ijk}})+\mathbb{1}\{R_{ijk} \neq b_k\}Ln(p_{b_{k}q_{ijk}})})$


$\hspace{5mm}$ 
$l_1={\displaystyle \sum_{B \in \{A,C,G,T\}}^{}}{\displaystyle \sum_{q=0}^{93}}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{ijk}=q}\}(\mathbb{1}\{R_{ijk} = B\}Ln(1-P_{Bq})+ \mathbb{1}\{R_{ijk} \neq B\}Ln(P_{Bq}))$


$\hspace{5mm}$ 
$\frac{dl_1}{dP_{BY}}={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}} (\frac{-\mathbb{1}\{R_{ijk}=B\}}{1-P_{BY}}+\frac{\mathbb{1}\{R_{ijk} \neq B\}}{P_{BY}}) = 0$


$\hspace{5mm}$ 
$={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}} ({-\mathbb{1}\{{R_{ijk}=B\}}(P_{BY})}+{\mathbb{1}\{R_{ijk} \neq B\}}({1-P_{BY}})) = 0$


$\\={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}} ({-\mathbb{1}\{{R_{ijk}=B\}}(P_{BY})})+{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}}({\mathbb{1}\{R_{ijk} \neq B\}}({1-P_{BY}})) = 0$

\bigbreak
$\\=-{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}} ({\mathbb{1}\{{R_{ijk}=B\}}(P_{BY})})
+{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}} ({\mathbb{1}\{{R_{ijk} \neq B\}}}) \\
-{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}}({\mathbb{1}\{R_{ijk} \neq B\}}({P_{BY}})) = 0$

\bigbreak
$\\={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}} ({\mathbb{1}\{{R_{ijk}=B\}}(P_{BY})})
+{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}}({\mathbb{1}\{R_{ijk} \neq B\}}({P_{BY}})) \\
={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}} ({\mathbb{1}\{{R_{ijk} \neq B\}}})$

\bigbreak
$\\=(P_{BY})({\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}} ({\mathbb{1}\{{R_{ijk}=B\}}})
-{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}}({\mathbb{1}\{R_{ijk} \neq B\}})) \\
= {\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}} ({\mathbb{1}\{{R_{ijk} \neq B\}}})$


%This is the final fraction for the H_1
$\hspace{10mm}$ 
$\hat P{_{BY}} = \frac{{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}} ({\mathbb{1}\{{R_{ijk} \neq B\}}})}{{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}} ({\mathbb{1}\{{R_{ijk}=B\}}})
+{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}} {\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{b_k=B,Q_{jk}=Y\}}({\mathbb{1}\{R_{ijk} \neq B\}})}$


%Equation for likelihood ratios
Therefore:

$\hspace{10mm}$ 
= $\frac{L_0}{L_1}$ 
\bigbreak
$\hspace{10mm}$ 
$= \frac{
{\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} (1-\hat{p}_{q_{ijk}})^{\mathbb{1}\{R_{ijk}=b_{k}\}}(\hat{p}_{q_{ijk}})^{\mathbb{1}\{R_{k} \neq b_{ijk}\}}}
{{\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} (1-\hat{p}_{b_{k}q_{ijk}})^{\mathbb{1}\{R_{ijk}=b_{k}\}}(\hat{p}_{b_{k}q_{ijk}})^{\mathbb{1}\{R_{ijk} \neq b_{k}\}}
}$
\bigbreak
Where $\hat{p}$ gives the maximizes the likelihood function, plug $\hat{p}$s back into likelihood function.




\bigbreak
$\textbf{Question 3b}:$

%This is where 3b begins

%This is the H_0
$H_0: p_{qbb'} = p_{qb} \forall b' \neq b$ 

for each $b \in \{A,C,G,T\}$ if the $H_0$ in Part a is rejected (otherwise, drop b from test)

\bigbreak

The probability of misreading a nucleotide is the same for each error base for all possible error bases
\bigbreak
Reject $H_0$ in 3a probability of a misread is different regardless of the true base - keep b 
\bigbreak
Fail to reject $H_0$ in 3a probability of a misread is not different for the true base - drop b.

%This is the H_0
\bigbreak
$H_0: p_{pbb'} = p_{q} \forall b' \neq b

%$\hspace{14mm}$ 
%$=1-p_{qbb'} = p_{q}$

$Parameters: p_0,p_2,...,p_{93} \in [0,1]$

\bigbreak
$L_0(p_0,p_2,...,p_{93}|Data) = L_0(Data|H_0;p_0,p_2,...,p_{93})$

Derived in 3a, refer to derivation of $H_0$ (of 3a) with b's removed.

\bigbreak
%This is where the H_1 begins

$H_1: p_{pbb'} = p_{qb'} \forall b' \neq b$

%$\hspace{14mm}$ 
%$=1-p_{qb'} = p_{qb}$

$Parameters: p_{A1},...,p_{G93}$

\bigbreak
$L_1(p_{A1},...,p_{G93}, b_k =B, Q_{ijk}=q_{ijk}|Data)$

$\hspace{5mm}$ 
$= Pr(Data|H_1;p_{A1},...,p_{G93}, Q_{ijk}=q_{ijk},b_k=B)$

$\hspace{5mm}$
$L_1={\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} Pr(R_{ijk}=r_{ijk}|H_1;p_{A1},...,p_{G93},b_k=B,Q_{ijk}=q_{ijk})$$}$


$\hspace{5mm}$
$L_1={\displaystyle \prod_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \prod_{X=0}^{93}}{\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}}[(1-P_{b'_kq_{ijk}})^{\mathbb{1}\{R_{ijk}=b_k\}}(P_{b'_kq_{ijk}})^{\mathbb{1}\{R_{ijk} = b'\}}]^{{\mathbb{1}\{Q=X\}}$


$\hspace{5mm}$
$\frac{\partial}{\partial P_{B'Q}} [l_1={\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{X=0}^{93}}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}} {\mathbb{1}\{Q=X\}[{\mathbb{1}\{R_{ijk}=b_k\}Ln(1-P_{b'_{k}q_{ijk}}) + {\mathbb{1}\{R_{ijk} = b'\}Ln(P_{b'_{k}q_{ijk}})]]$


$\hspace{10mm}$
$={\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}} [\frac{\mathbb{1}\{R_{ijk}=b_k\}}{1-P_{B'Q}} + \frac{\mathbb{1}\{R_{ijk} = b'\}}{P_{B'Q}}]$


$\hspace{10mm}$
$={\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}} [{\mathbb{1}\{R_{ijk}=b_k\}}{(P_{B'Q})} + {\mathbb{1}\{R_{ijk} = b'\}}{(1-P_{B'Q})}] =0$

\bigbreak

$\hspace{10mm}$
$={\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}} (\mathbb{1}\{R_{ijk}=b_k\}P_{B'Q}) +

{\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}}(\mathbb{1}\{R_{ijk} = b'\}(1-P_{B'Q})) = 0$

\bigbreak


$\hspace{5mm}$
$=-{\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}} (\mathbb{1}\{R_{ijk}=b_k\}P_{B'Q}) + {\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}}(\mathbb{1}\{R_{ijk} = b'\}(1-P_{B'Q}))

-{\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}}({\mathbb{1}\{R_{ijk} = b'\}P_{B'Q})} = 0$


\bigbreak

$=(P_{B'Q})({\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}} (\mathbb{1}\{R_{ijk}=b_k\}) + {\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}}({\mathbb{1}\{R_{ijk} = b'\})}) 

= {\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}}{\mathbb{1}\{R_{ijk} = b'\}}$


\bigbreak

$\hat{P}_{B'Q} = $$\frac{{\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}}{\mathbb{1}\{R_{ijk} = b'\}}}}{{\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}} (\mathbb{1}\{R_{ijk}=b'\}) + {\displaystyle \sum_{b' \in \{A,C,G,T\},b'\neq b}{\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}{\mathbb{1}\{Q=X\}}({\mathbb{1}\{R_{ijk} = b'\})}}}}$

\bigbreak
%Equation for likelihood ratios
Therefore:

$\hspace{10mm}$ 
= $\frac{L_0}{L_1}$ 
\bigbreak
$\hspace{10mm}$ 
$= \frac{{\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} (1-\hat{p}_{q_{ijk}})^{\mathbb{1}\{R_{ijk}=b_{k}\}}(\hat{p}_{q_{ijk}})^{\mathbb{1}\{R_{k} \neq b_{ijk}\}}}{{{\displaystyle \prod_{b' \in \{A,C,G,T\},b'\neq b}\displaystyle \prod_{X=0}^{93}}{\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}}[(1-\hat{p}_{b'_kq_{ijk}})^{\mathbb{1}\{R_{ijk}=b_k\}}(\hat{p}_{b'_kq_{ijk}})^{\mathbb{1}\{R_{ijk} = b'\}}]^{{\mathbb{1}\{Q=X\}}}}}$

\bigbreak
Where $\hat{p}$ gives the maximizes the likelihood function, plug $\hat{p}$s back into likelihood function.


\bigbreak
$\textbf{Question 3c}:$
%This is the H_0

$H_0: p_{pbb'} = \frac{1}{3}10^{\frac{-q_{ijk}}{10}} \forall b,b' \in \{A,C,G,T\}$

$Parameters: p_0 = \frac{1}{3}10^{\frac{-1}{10}} ,...,p_{93} =\frac{1}{3}10^{\frac{-93}{10}} \in [0,1]$

\bigbreak
$L_0(\frac{1}{3}10^{\frac{-1}{10}},...,\frac{1}{3}10^{\frac{-93}{10}}|Data)$

$\hspace{5mm}$ $=Pr(Data|H_0;\frac{1}{3}10^{\frac{-1}{10}},...,\frac{1}{3}10^{\frac{-93}{10}})$


$\hspace{5mm}$
$L_0={\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} Pr(R_{ijk}=r_{ijk}|H_0;\frac{1}{3}10^{\frac{-1}{10}},...,\frac{1}{3}10^{\frac{-93}{10}},b_k=B,Q_{ijk}=q_{ijk})$$}$

$\hspace{5mm}$
$L_0={\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}}$ $1-\frac{1}{3}10^{\frac{-q_{ijk}}{10}^{\mathbb{1}\{R_{ijk}=b_k\}}}$ $\frac{1}{3}10^{\frac{-q_{ijk}}{10}^{\mathbb{1}\{R_{ijk} \neq b_k\}}}}$

$\hspace{5mm}$
$l_0={\displaystyle \sum_{i=1}^{3}}{\displaystyle \sum_{j=1}^{l_i}}{\displaystyle \sum_{k=1}^{m_i}}$${\mathbb{1}\{R_{ijk}=b_k\}}Ln(1-\frac{1}{3}10^{\frac{-q_{ijk}}{10}}})$$+{\mathbb{1}\{R_{ijk} \neq b_k\}}Ln(\frac{1}{3}10^{\frac{-q_{ijk}}{10}}})$


\bigbreak
%This is where the H_1 begins

$H_1: p_{pbb'} = p_q$

$Parameters: p_{0},...,p_{93}$

\bigbreak
$L_1(p_{0},...,p_{93}, b_k =B, Q_{ijk}=q_{ijk}|Data)$

$\hspace{5mm}$ 
$= Pr(Data|H_1;p_{0},...,p_{93}, Q_{ijk}=q_{ijk},b_k=B)$


$\hspace{5mm}$
$L_1={\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} Pr(R_{ijk}=r_{ijk}|H_1;p_{0},...,p_{93},b_k=B,Q_{ijk}=q_{ijk})$$}$


Derived in 3a, refer to derivation of $H_0$ (of 3a) with b's, and b''s removed.



%Equation for likelihood ratios
Therefore:

$\hspace{10mm}$ 
= $\frac{L_0}{L_1}$ 
\bigbreak
$\hspace{10mm}$ 
$= \frac{{\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} 1-\frac{1}{3}10^{\frac{-q_{ijk}}{10}^{\mathbb{1}\{R_{ijk}=b_k\}}}\frac{1}{3}10^{\frac{-q_{ijk}}{10}^{\mathbb{1}\{R_{ijk} \neq b_k\}}}}{{{\displaystyle \prod_{i=1}^{3}}{\displaystyle \prod_{j=1}^{l_i}}{\displaystyle \prod_{k=1}^{m_i}} (1-\hat{p}_{q_{ijk}})^{\mathbb{1}\{R_{ijk}=b_{k}\}}(\hat{p}_{q_{ijk}})^{\mathbb{1}\{R_{k} \neq b_{ijk}\}}}}$






\end{document}
