\name{jul}
\alias{jul}
\alias{jul.Date}
\alias{jul.IDate}
\alias{jul.default}
\alias{jul.ti}
\alias{jul.yearmon}
\alias{jul.yearqtr}
\alias{as.jul}
\alias{asJul}
\alias{is.jul}
\title{ Julian Date Objects }
\usage{
jul(x, \dots)
\method{jul}{Date}(x, \dots)
\method{jul}{IDate}(x, \dots)
\method{jul}{ti}(x, offset = 1, \dots)
\method{jul}{yearmon}(x, offset = 0, \dots)
\method{jul}{yearqtr}(x, offset = 0, \dots)
\method{jul}{default}(x, \dots)
as.jul(x, \dots)
asJul(x)
is.jul(x)
}
\description{
  The function \code{jul} is used to create \code{jul} (julian date)
  objects, which are useful for date calculations.

  \code{as.jul} and \code{asJul} coerce an object to class "jul", the
  difference being that \code{as.jul} calls the constructor \code{jul},
  while \code{asJul} simply forces the class of its argument to be "jul"
  without any checking as to whether or not it makes sense to do so.
  
  \code{is.jul} tests whether an object inherits from class "jul".

}
\arguments{
    \item{x}{
	object to be tested (\code{is.jul}) or converted into a \code{jul}
	object.  As described in the details below, the constructor function
	\code{jul} can deal with several different kinds of \code{x}. 
  }
  \item{\dots}{
	other args to be passed to the method called by the generic
	function.  \code{jul.default} may pass these args to \code{as.Date}.
  }
  \item{offset}{
	For \code{jul.ti}, a number in the range [0,1] telling where in the
	period represented by \code{x} to find the day.  0 returns the first
	day of the period, while the default value 1 returns the last day of
	the period.  For example, if \code{x} has \code{tif} = "wmonday" so
	that \code{x} represents a week ending on Monday, than any
	\code{offset} in the range [0, 1/7] will return the Tuesday of that
	week, while \code{offset} in the range (1/7, 2/7] will return the
	Wednesday of that week, \code{offset} in the range (6/7, 1] will
	return the Monday that ends the week, and so on.

	\code{jul.yearmon} and \code{jul.yearqtr} work on \code{yearmon} and
	\code{yearqtr} objects from \pkg{zoo}.  Note that the default
	\code{offset} for these functions is 0, not 1, as that is how the
	other index-to-date functions in \pkg{zoo} work, i.e, if \code{ym}
	is a \code{yearmon} object, then \code{as.Date(ym)} and
	\code{as.jul(ym)} should give the same date.
  }
}
\details{
  The \code{jul}'s for any pair of valid dates differ by the number of
  days between them.  \R's \code{Date} class defines a Date as a number
  of days elapsed since January 1, 1970, but \code{jul} uses the
  encoding from the \emph{Numerical Recipes} book, which has Jan 1, 1970
  = 2440588, and the code for converting between ymd and \code{jul}
  representations is a straightforward port of the code from that tome.

  Adding an integer to, or subtracting an integer from a \code{jul}
  results in another \code{jul}, and one \code{jul} can be subtracted
  from another.  Two \code{jul}'s can also be compared with the
  operators (\code{==, !=, <. >, <=, >=}).

  The \code{jul} class implements methods for a number of generic
  functions, including \code{"["}, \code{as.Date}, \code{as.POSIXct},
  \code{as.POSIXlt}, \code{c}, \code{format}, \code{max},
  \code{min}, \code{print}, \code{rep}, \code{seq}, \code{ti},
  \code{time}, \code{ymd}.
  
  \code{jul} is a generic function with specialized methods to handle
  \code{Date} and \code{ti} objects. A recent addition is a method to
  handle \code{IDate} objects as defined in the \pkg{data.table}
  package. 
  
  The default method (\code{jul.default}) deals with character \code{x} by
  calling \code{as.Date} on it.  Otherwise, it proceeds as follows:

  If \code{x} is numeric, \code{isYmd} is used to see if it could be
  yyyymmdd date, then \code{isTime} is called to see if \code{x} could
  be a decimal time (a number between 1799 and 2200). If all else fails,
  \code{as.Date(x)} is called to attempt to create a \code{Date} object
  that can then be used to construct a \code{jul}.  
}
\value{
  \code{is.jul} returns \code{TRUE} or \code{FALSE}.
  
  \code{as.jul} and \code{asJul} return objects with class "jul".
  
  \code{jul} constructs a \code{jul} object like \code{x}.
  
  \code{jul} with no arguments returns the \code{jul} for the current day.
}
\references{
  Press, W. H., Teukolsky, S. A., Vetterling, W. T., and Flannery,
  B. P. (1992).
  \emph{Numerical Recipes: The Art of Scientific Computing (Second
    Edition)}.
  Cambridge University Press.
}
\note{
  The return value from \code{asJul} is not guaranteed to be a valid
  \code{jul} object.  For example, \code{asJul("a")} will not throw an
  error, and it will return the string "a" with a class attribute "jul",
  but that's not a valid julian date. 

  The Julian calendar adopted by the Roman Republic was not
  accurate with respect to the rotational position of the Earth around
  the sun.  By 1582 it had drifted ten days off.  To fix this, Pope Gregory XIII
  decreed that the day after October 4, 1582 would be October 15, and
  that thereafter, leap years would be omitted in years divisible by 100
  but not divisible by 400.  This modification became known as the
  Gregorian calendar.  England and the colonies did not switch over
  until 1752, by which time the drift had worsened by another day, so
  that England had to skip over 11 days, rather than 10.

  The algorithms used in \code{jul2ymd} and \code{ymd2jul} cut over at
  the end of October 1582.

}
\seealso{ \code{\link{jul}}, \code{\link{ymd}}, \code{\link{ti}}, \code{\link{as.Date}}}
\examples{
dec31 <- jul(20041231)
jan30 <- jul("2005-1-30")
jan30 - dec31              ## 30
feb28 <- jan30 + 29
jul()                      ## current date
}
\keyword{ chron }
