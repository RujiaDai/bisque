% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reference_based.R
\name{ReferenceBasedDecomposition}
\alias{ReferenceBasedDecomposition}
\title{Performs reference-based decomposition of bulk expression using single-cell
data}
\usage{
ReferenceBasedDecomposition(bulk.eset, sc.eset, markers = NULL,
  cell.types = "cellType", subject.names = "SubjectName",
  use.overlap = TRUE, verbose = TRUE)
}
\arguments{
\item{bulk.eset}{Expression Set containin bulk data. No PhenoData required
but if overlapping option used, IDs returned by sampleNames(bulk.eset) 
should match those found in sc.eset phenoData individual labels.}

\item{sc.eset}{Expression Set containing single-cell data. PhenoData of this
Expression Set should contain cell type and individual labels for each
cell. Names of these fields specified by arguments below.}

\item{markers}{Structure, such as character vector, containing marker genes
to be used in decomposition. `base::unique(base::unlist(markers))` should
return a simple vector containing each gene name. If no argument or NULL
provided, the method will use all available genes for decomposition.}

\item{cell.types}{Character string. Name of phenoData attribute in sc.eset
indicating cell type label for each cell}

\item{subject.names}{Character string. Name of phenoData attribute in sc.eset
indicating individual label for each cell}

\item{use.overlap}{Boolean. Whether to use and expect overlapping samples 
in decomposition.}

\item{verbose}{Boolean. Whether to print log info during decomposition.
Errors will be printed regardless.}
}
\value{
A list. Slot \strong{bulk.props} contains a matrix of cell type
  proportion estimates with cell types as rows and individuals as columns.
  Slot \strong{sc.props} contains a matrix of cell type proportions 
  estimated directly from counting single-cell data. 
  Slot \strong{rnorm} contains Euclidean norm of the residuals for each
  individual's proportion estimates. Slot \strong{genes.used} contains
  vector of genes used in decomposition
}
\description{
Generates a reference profile based on single-cell data. Learns a
transformation of bulk expression based on observed single-cell proportions
and performs  NNLS regression on these transformed values to estimate cell
proportions.
}
\details{
Expects read counts for both datasets, as they will be converted to 
counts per million (CPM). Two options available: Use overlapping indivudals
found in both single-cell and bulk datasets to learn transformation or 
learn transformation from single-cell alone. The overlapping option is
expected to have better performance.
}
\examples{
library(Biobase)
sim.data <- SimulateData(n.ind=10, n.genes=100, n.cells=100,
                         cell.types=c("Neurons", "Astrocytes", "Microglia"),
                         avg.props=c(.5, .3, .2))
sim.data$sc.eset <- sim.data$sc.eset[,sim.data$sc.eset$SubjectName \%in\% as.character(6:10)]
res <- ReferenceBasedDecomposition(sim.data$bulk.eset, sim.data$sc.eset)
estimated.cell.proportions <- res$bulk.props

}
