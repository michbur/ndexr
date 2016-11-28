##Authors:
#   Alex Ishkin [aleksandr.ishkin@thomsonreuters.com]
#   Dexter Pratt [depratt@ucsd.edu]
#   Frank Kramer [frank.kramer@med.uni-goettingen.de]
#   Florian Auer [florian.auer@med.uni-goettingen.de]
## Created: 1 June 2014
## Base functions to perform HTTP transactions to an NDEX server via the NDEx REST API
## Updated to NDEX v1.0 API 1 November 2014
## Updated to use NDEXConnection object to store connection informations 15 September 2016


#' Connect to NDEx REST API
#' 
#' This function creates an NDEXConnection which stores options and authentication details. It is a parameter required for most of the other ndexr functions.
#' If username and password are missing an anonymous connection is created, which already offers most of the retrieval functionality.
#' 
#' @param username character username
#' @param password character password
#' @param host (optional) URL of NDEx REST server to be used; Default is: http://www.ndexbio.org/rest
#' @param apiversion character (optional) Version of NDEx REST server; Default is version "2.0"
#' @param verbose logical; whether to print out extended feedback 
#' @return returns object of class NDEXConnection which stores options and authentication if successfull, NULL otherwise
#' @export
#' @examples
#' \dontrun{ndexcon = ndex.connect(verbose=T)}
ndex.connect <- function(username, password, host = "http://www.ndexbio.org/rest", apiversion = '2.0', verbose = FALSE){

  credentials = TRUE
  if(missing(username) || missing(password)){
    message("Connecting anonymously - username or password not supplied")
    credentials = FALSE
  } 
  
  if(missing(host)) if(verbose) message("ndex.connect: host not specified, using default")
  
  ##Attempt authentication if we have credentials
  if (credentials){
    try(auth_response <- RCurl::getURL(paste0(host, "/user/authenticate/", username, "/", password)))
    if(jsonlite::validate(auth_response)){
      auth_response <- jsonlite::fromJSON(auth_response)
      #print(auth_response)
      ##Authentication successful (JSON with user data was returned)
      ndex.opts <- RCurl::curlOptions(userpwd = paste0(username, ":", password), httpauth = 1L)
       
      if(verbose) message("\n", host, " is responding as an NDEx REST server ", "\nAuthentication of [", auth_response$accountName, "] is successful!\n",  sep='')
    } else{
      stop(paste("Tried ndex.connect with credentials. response = ", auth_response))
    }
  } else {
    ##Check response of standard admin query
    try(auth_response <- RCurl::getURL(paste0(host, "/network/api")))
    if(jsonlite::validate(auth_response)){
      ndex.opts <- RCurl::curlOptions(httpauth = 1L)
      if(verbose) message(host, " responding as NDEx REST server",  sep='')
    }else{
      stop(paste("ndex.connect:", auth_response))
    }       
  }
  

  if(credentials) {
    ndexcon = list(anon=FALSE, credentials=credentials, current.user= auth_response$accountName, curl.opts=ndex.opts, host=host, apiversion=apiversion, verbose=verbose)
  } else {
    ndexcon = list(anon=TRUE, curl.opts=ndex.opts, host=host, apiversion=apiversion, verbose=verbose)
  }
  class(ndexcon) = c("NDExConnection",class(ndexcon))
  return(ndexcon)
}

#' Check if user is authenticated to NDEx REST server
#' 
#' This function checks if the supplied NDEXConnection object allows user access to the NDEx server. It will fail for anonymous NDEXConnection objects.
#' 
#' @param ndexcon object of class NDEXConnection
#' @return logical (TRUE if user is authenticated and connection is active, FALSE otherwise)
#' @export
#' @examples
#' \dontrun{
#'  ndexcon = ndex.connect(verbose=T)
#'  ndex.alive(ndexcon) # should return FALSE since ndexcon is anonymous
#'  }
ndex.alive <- function(ndexcon){
  if(missing(ndexcon)) return(FALSE)
  if(ndexcon$anon == TRUE) {
    warning("Called ndex.alive on anonymous NDExConnection object. Returning false.")
    return(FALSE)
  }

  ##Try getting something from API again
  test <- NULL
  try(test <- RCurl::getURL(paste0(ndexcon$host, "/user/", ndexcon$current.user), .opts=ndexcon$curl.opts))   ### ToDo: change to ndex.api and test! No hard-coded urls!!
  {
    if(is.null(test)){
      return(FALSE)
    }else{
      if(jsonlite::validate(test)) return(TRUE)
      else return (FALSE)
    }
  }
}


#################################################
##Low-level REST-querying functions

#' Generic GET query to API. 
#' 
#' This functions is internal.
#' 
#' @param ndexcon object of class NDEXConnection
#' @param route Character (route to specific REST query)
#' @param raw Specifies if server response should be returned in raw, or if jsonlite::fromJSON is called first. Defaults to FALSE.
#' @return JSON response from REST server, NULL if no valid JSON was received. if parameter raw is TRUE, the raw response is returned without a call to jsonlite::fromJSON.
#' @details Simply execute HTTP GET on URL host/route and fetch whatever data REST server returns 
#' Making sure the route is well-formed is the job of calling function
#' @seealso \code{\link{ndex_rest_PUT}},  \code{\link{ndex_rest_POST}},  \code{\link{ndex_rest_PUT}}
#' @examples
#' \dontrun{
#' ndexcon = ndex.connect(verbose=T)
#' ndex_rest_GET(ndexcon, "/networks/api")
#' }
ndex_rest_GET <- function(ndexcon, route, raw = FALSE){
  url <- paste0(ndexcon$host, route)
  if(ndexcon$verbose) message("\nGET: [ ", url, " ]\n")
  content <- RCurl::getURL(url, .opts=ndexcon$curl.opts)
  if(ndexcon$verbose) message('Response:', substring(content, 1, 300), '...', sep = '\n')
  if(raw) return(content)
  if(jsonlite::validate(content)) {
    return(jsonlite::fromJSON(content))
  } else {
    return(NULL)
  }
}

#' Generic PUT query to API
#' 
#' This functions is internal.
#' 
#' @param ndexcon object of class NDEXConnection
#' @param route Character (route to specific REST query)
#' @param data Whatever data to be supplied with query. Should be valid JSON
#' @param raw Specifies if server response should be returned in raw, or if jsonlite::fromJSON is called first. Defaults to FALSE.
#' @return JSON response from REST server, NULL if no valid JSON was received. if parameter raw is TRUE, the raw response is returned without a call to jsonlite::fromJSON.
#' @details Simply execute HTTP PUT on URL host/route and fetch whatever data REST server returns 
#' Making sure the route is well-formed is the job of calling function
#' Making sure the data is well-formed is also the job of calling function
#' @seealso \code{\link{ndex_rest_GET}},  \code{\link{ndex_rest_POST}},  \code{\link{ndex_rest_PUT}}
#' @examples
#' ##TBD
ndex_rest_PUT <- function(ndexcon, route, data, raw = FALSE){
  if(!jsonlite::validate(data)) stop(sprintf("Malformed JSON input for PUT query: %s", data))
  url <- paste0(ndexcon$host, route)
  
  rdata <- charToRaw(data)

  h = RCurl::basicTextGatherer()
  h$reset()
  #cat('rdata:',rdata,'\nlength:',dim(data), sep='')
  ## ToDo: PUT does not work! maybe change to httr!
  # stops after < HTTP/1.1 100 Continue
  #kills the R session?!?!?!?!?
  RCurl::curlPerform(url = url,
              httpheader=c('Content-Type' = "multipart/form-data"),
              customrequest = "PUT",
              postfields = data,
              writefunction = h$update,
              .opts = ndexcon$curl.opts,
              verbose=TRUE)
  
  content = h$value()
  
  ## curl -i -H 'Content-Type: multipart/form-data' -X PUT -F CXNetworkStream=@a5db7097-b30c-11e6-831a-06603eb7f303.json --user testacc:testacc http://www.ndexbio.org/rest/network/asCX/a5db7097-b30c-11e6-831a-06603eb7f303
  # for some reason switches to GET?!
  # but only if .opts (e.g. userpwd) is set
  # content <- httpPUT(url=url,
  #                    content=data ,
  #                    .opts=ndexcon$curl.opts,
  #                    httpheader=c('Content-Type' = "multipart/form-data"))
  #url='http://requestb.in/1gubuc61'
  # content <- httpPUT(url=url,
  #                    content=rdata,
  #                    httpheader=c('Content-Type' = "multipart/form-data"),
  #                    httpauth=T,
  #                    userpwd=ndexcon$curl.opts$userpwd)
   
  
  if(ndexcon$verbose) message('Response:', substring(content, 1, 300), '...', sep = '\n')
  if(raw) return(content)
  if(jsonlite::validate(content)) {
    return(jsonlite::fromJSON(content))
  } else {
    return(NULL)
  }
}


#' Generic POST query to API
#' 
#' @param ndexcon object of class NDEXConnection
#' @param route Character (route to specific REST query)
#' @param data Whatever data to be supplied with query. Should be valid JSON
#' @param multipart Whatever data to be supplied with query. Should be valid JSON
#' @param raw Specifies if server response should be returned in raw, or if jsonlite::fromJSON is called first. Defaults to FALSE.
#' @return JSON response from REST server, NULL if no valid JSON was received. if parameter raw is TRUE, the raw response is returned without a call to jsonlite::fromJSON.
#' @details Simply execute HTTP PUT on URL host/route and fetch whatever data REST server returns 
#' Making sure the route is well-formed is the job of calling function
#' Making sure the data is well-formed is also the job of calling function
#' @seealso \code{\link{ndex_rest_GET}},  \code{\link{ndex_rest_PUT}},  \code{\link{ndex_rest_POST}}
#' @examples
#' ##TBD
ndex_rest_POST <- function(ndexcon, route, data, multipart = FALSE, raw = FALSE){
  if(!jsonlite::validate(data)) stop(sprintf("Malformed JSON input for POST query: %s", data))
  url <- paste0(ndexcon$host, route)
  if(ndexcon$verbose) message("\nPOST: [ ", url, " ]\n")

  if(multipart){
    #cat('url:',url,'\ndata:',data,'\nopts:',ndexcon$curl.opts,sep='')
    content = RCurl::postForm(url,
                              .params = data,
                              .opts=ndexcon$curl.opts)
  }else{
    h = RCurl::basicTextGatherer()
    h$reset()
    RCurl::curlPerform(url = url,
                postfields = data,
                httpheader = c('Content-Type' = "application/json"),
                writefunction = h$update,
                .opts=ndexcon$curl.opts)
    
    content = h$value()
  }
  if(ndexcon$verbose) message('Response:', substring(content, 1, 300), '...', sep = '\n')
  if(raw) return(content)
  if(jsonlite::validate(content)) {
    return(jsonlite::fromJSON(content))
  } else {
    return(NULL)
  }
}


#' List possible queries to NDEx API
#' 
#' This function returns a data.frame listing all the possible API calls supported by the NDEx server.
#' 
#' @param ndexcon object of class NDEXConnection
#' @return data.frame detailing the API names, paths, parameters and athentication needed for API requests.
#' @details Retrieves information on the NDEx API calls
#' @seealso \code{\link{ndex_rest_GET}},  \code{\link{ndex_rest_PUT}},  \code{\link{ndex_rest_POST}}
#' @export
#' @examples
#' \dontrun{
#' ndexcon = ndex.connect(verbose=T)
#' ndex.get.network.api(ndexcon)
#' }
ndex.get.network.api <- function(ndexcon){
  route <- "/network/api"       ## ToDo: change to ndex.api and test! No hard-coded urls!!
  response <- ndex_rest_GET(ndexcon,route)
  #  df <- data.frame(path = sapply(response, `[[`, 'path'),
  #                   description = sapply(response, `[[`, 'apiDoc'),
  #                   requestType = sapply(response, `[[`, 'requestType'),stringsAsFactors = FALSE)
  return(response)
}
