\ProvidesClass{moderncurriculum}[2019/09/2019 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%----------------------------------------------------------------------------------------
% REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\usepackage{mathptmx}
\usepackage[11pt]{moresize}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%----------------------------------------------------------------------------------------
% COLOURS
%----------------------------------------------------------------------------------------

\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{095687}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{mainblack}{HTML}{095687}
\definecolor{maingray}{HTML}{B9B9B9}
\colorlet{fillheader}{gray}
\colorlet{headercolor}{gray}

%----------------------------------------------------------------------------------------
% MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

\renewcommand{\bfseries}{\color{gray}} % Troca o \textbf para texto colorido
\pagestyle{empty} % Desabilita os cabeçalhos e rodapés
\setlength{\parindent}{0pt} % Desabilita a identação dos paragrafos

%----------------------------------------------------------------------------------------
% SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm} % Margem esquerda
\setlength{\TPVertModule}{1cm} % Margem de cima

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength} % Definir o tamanho do comprimento depois do titulo
\newlength{\SectionTitleLength} % Definir o tamanho da largura depois do titulo
\newcommand{\profilesection}[1]{%
	\setlength\TotalSectionLength{\linewidth}% Definir a quantidade de linhas
	\settowidth{\SectionTitleLength}{\huge #1 }% Calcula a largura da seção do titulo
	\addtolength\TotalSectionLength{-\SectionTitleLength}% Subtract the section title width from the total width
	\addtolength\TotalSectionLength{-2.22221pt}% Modifier to remove overfull box warning
	\vspace{8pt}% Whitespace before the section title
	{\color{black!80} \huge #1 \rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}% Print the title and auto-width rule
}

\newcommand{\birth}[1]{\renewcommand{\birth}{#1}}
\newcommand{\mail}[1]{\renewcommand{\mail}{#1}}
\newcommand{\phonenumber}[1]{\renewcommand{\phonenumber}{#1}}
\newcommand{\address}[1]{\renewcommand{\address}{#1}}
\newcommand{\site}[1]{\renewcommand{\site}{#1}}
\newcommand{\profile}[1]{\renewcommand{\profile}{#1}}
\newcommand{\languages}[1]{\renewcommand{\languages}{#1}}
\newcommand{\skills}[1]{\renewcommand{\skills}{#1}}

% Command for printing the contact information icons
\newcommand*\icon[1]{%
                \tikz[baseline=(char.base)]{%
                    \node[ shape=circle,
                           draw,
                           inner sep=1pt, 
                           fill=mainblack,
                           mainblack,
                           text=white
                         ] (char) {#1};%
                }%
            }    

% Command for printing  text
\newcommand\knowledge[1]{ 
	\renewcommand{\knowledge}{
		\begin{flushleft}
			\foreach [count=\i] \x in {#1}{ 
				\x
			}
		\end{flushleft}
	}
}

%----------------------------------------------------------------------------------------
%	 SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

\newcommand{\sidebar}{
	\begin{tikzpicture}[remember picture,overlay]
   		\node [rectangle, fill=sidecolor, anchor=north, minimum width=9.5cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.15cm){};
	\end{tikzpicture}
	
	%------------------------------------------------

	\begin{textblock}{6}(0.5, -0.5)
		\ifthenelse{\equal{true}{}}{}{
			\begin{center}
				\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
					\clip (600/2, 567/2) circle (567/2);
				\end{tikzpicture}
			\end{center}
		}
        \ifthenelse{\equal{Detalhes}{}}{}{
			\profilesection{Contatos}\newline
		}
		
		\renewcommand{\arraystretch}{1.6}
		\begin{tabular}{p{0.5cm} @{\hskip 0.5cm}p{5cm}}
			
			\ifthenelse{\equal{\phonenumber}{}}{}{\textsc{\Large\icon{\Telefon}} & \phonenumber\\}
			\ifthenelse{\equal{\site}{}}{}{\textsc{\Large\icon{\Mundus}} & \href{\site}{\site}\\}
			\ifthenelse{\equal{\mail}{}}{}{\textsc{\large\icon{@}} & \href{mailto:\mail}{\mail}\\}
			\ifthenelse{\equal{\address}{}}{}{\vspace{-10 pt}\textsc{\Large\icon{\Letter}} & \address\\}
		\end{tabular}
		\ifthenelse{\equal{\profile}{}}{}{
		    \newline\newline
			\profilesection{Perfil}
			\justify
			\profile
		}%
		
		%------------------------------------------------
        \begin{flushleft}
		\profilesection{Skills}
		\end{flushleft}
		\knowledge
		\scriptsize


		%------------------------------------------------
		
		\ifthenelse{\equal{\languages}{}}{}{
			\begin{flushleft}
			\profilesection{Languages}
			\newline\newline
			\normalsize{\languages}
			\end{flushleft}
		}
		
		%------------------------------------------------
			
	\end{textblock}
}

%----------------------------------------------------------------------------------------
%	 COLOURED SECTION TITLE BOX
%----------------------------------------------------------------------------------------

% Command to create the rounded boxes around the first three letters of section titles
\newcommand*\round[2]{%
	\tikz[baseline=(char.base)]\node[anchor=north west, draw,rectangle, line width=1mm, inner xsep=10pt, minimum size=5.2mm, minimum width=13cm, minimum height=0.3cm, text height=0.3cm, text width=13cm, fill=#2,#2,text=white](char){#1};%
	

}

\newcounter{colorCounter}
\newcommand{\sectioncolor}[1]{%
	{%
		\round{#1}{
			\ifcase\value{colorCounter}%
			mainblack\or%
			mainblack\or%
			mainblack\or%
			mainblack\or%
			mainblack\or%
			mainblack\or%
			mainblack\or%
			mainblack\or%
 			mainblack\or%
			mainblack\else%
			mainblack\fi%
		}%
	}%
	\stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
	{%
		\color{gray}%
		\Large\sectioncolor{#1}%
	}
}

\renewcommand{\subsection}[1]{
	\par\vspace{.5\parskip}{%
		\large\color{gray} #1%
	}
	\par\vspace{.25\parskip}%
}

%----------------------------------------------------------------------------------------
% LONG LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the long list
\newenvironment{biglist}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newcommand{\biglistitem}[4]{%
	#1&\parbox[t]{0.83\textwidth}{%
		\textbf{\MakeUppercase{#2}}%
		\hfill%
		{\footnotesize#3}\\%
		#4\vspace{\parsep}%
	}\\\\
}

%----------------------------------------------------------------------------------------
%	 SMALL LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the small list
\newenvironment{shortlist}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newcommand{\shortlistitem}[4]{%
	#1&\parbox[t]{0.83\textwidth}{%
		\textbf{\MakeUppercase{#2}}%
		\hfill%
		{\footnotesize#3}\\%
		#4\vspace{\parsep}%
	}\\
}

%----------------------------------------------------------------------------------------
%	 MARGINS AND LINKS
%----------------------------------------------------------------------------------------

\RequirePackage[left=7.6cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax

%----------------------------------------------------------------------------------------
%	 HEADER
%----------------------------------------------------------------------------------------

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
    \node [rectangle, line width=1mm, minimum height=1.1cm, inner xsep=20pt, draw=gray, anchor=south] (name) at (box) {%
    \vspace{30pt}
     \color{white}%
      {\HUGE  #1}
    };
    \node [anchor=north] (sub) at (name.south) {%
      \color{white}% 
      \Large \MakeUppercase{#2}%
    };
  \end{tikzpicture}
  \vspace{3.5cm}
  \vspace{-2\parskip}
}