TDTR_OffsetBeam (BO-TDTR)
===============

Package for Analyzing Offset-Beam Time Domain Thermoreflectance Experiments

Contents (Folders->Files):

Main_Calls Folder:  contains the primary scripts intended to perform the simulations.  Most users will just use these.

	- BO_TDTR_FWHM_MAIN: script calculates the FWHM of Vout for a given thermal system
	- BO_TDTR_ScanSimulator_MAIN: script simulates the beam-offset scan (Vin,Vout,ratio vs offset) and fits the in-phase with a Gaussian for a given thermal system

Primary_Functions Folder: contains high levels functions called by the "Main_Calls"

	- BO_TDTR_Scan: function that evaluates the beam offset scan (multiple offsets, single time delay)
	- BO_TDTR_getVout: function that evaluates the beam offset scan at a single offset
	- BO_TDTR_FWHM: function that calculates the FWHM of Vout

TDTR Folder:  Function to calculate the TDTR signal

	- BO_TDTR_Sig:  function that calculates the beam offset signal (single offset, multiple time delays)

FDTR Folder:  Functions for calculating the beam-offset frequency domain response

	- BO_TDTR_TEMP: function that calculates the frequency domain response (multiple frequencies), this functions needs...
	- BO_TDTR_GetSHankel: function the calculates the probe beam intensity Hankel function, this function also needs...
	- BO_TDTR_GetPolyCoefs: function that calculates the polynomial coefficients needed for "BO_TDTR_GetSHankel"

Utilities Folder:  Other functions required for the code to work (not specific to BO-TDTR)

	- rombint_multi: Romberg Integrator that can handle multiple integrands simultaneously (i.e. multi-frequency in FDTR response)
	- polyadd:  function to help "BO_TDTR_GetPolyCoefs" concatanate coefficients
	- BO_TDTR_Define_System:  combines thermal system parameters into a single object to be passed between functions