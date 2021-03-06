% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ndex_users.R
\name{ndex_find_users}
\alias{ndex_find_users}
\title{Search user in NDEx}
\usage{
ndex_find_users(ndexcon, searchString = "", start, size)
}
\arguments{
\item{ndexcon}{object of class NDExConnection link{ndex_connect}}

\item{searchString}{string by which to search}

\item{start}{integer (optional); specifies that the result is the nth page of the requested data. The default value is 0}

\item{size}{integer (optional); specifies the number of data items in each page. The default value is 100}
}
\value{
Data frame with user information; NULL if no user are found.
}
\description{
Returns a SearchResult object which contains an array of User objects
}
\note{
Compatible to NDEx server version 1.3 and 2.0

Search strings may be structured
}
\section{REST query}{

GET: ndex_config$api$search$user
}

\examples{
## Establish a server connection
ndexcon = ndex_connect()
## Find a user
users = ndex_find_users(ndexcon,"ndextutorials") 
names(users)
## [1] "properties"    "displayName"       "isIndividual"  "userName"     "password"        
## [6] "isVerified"    "firstName"         "lastName"      "diskQuota"    "diskUsed"        
##[11] "emailAddress"  "image"             "website"       "description"  "externalId"
##[16] "isDeleted"     "modificationTime"  "creationTime"    
}
