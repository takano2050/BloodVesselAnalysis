<p><strong>BloodVesselAnalysis</strong></p>
<p>This project provides a workflow of extracting changes in blood vessel diameter captured by two-photon microscopy. Blood Vessels are visualized through fluorescence dyes such as dextran-conjugated fluorescein.</p>
<p><br />The first program (BloodV10.exe) analyzes a time-series movie of a blood vessel. The program identifies the blood vessel within a region of interest (ROI) and draws multiple cross-sectional lines that are perpendicular to the centerline of the vessel. It then generates kymographs, time series of line profiles. Some of the movies are heavily affected by a brain motion and images become out-of-focus. To exclude those events, we implemented a method to characterize degree of focus shift of the movie. We measure edge sharpness of ROI for each time point and saves the focus measure along with the kymographs.</p>
<p><br />The second program (KymoHT6.exe) analyzes the kymograph generated by BloodV10 (or any kymographs in .tif format). It first applies spatial smoothing filter (default 7x1 pixels, or choice of mxn filter). Note that the filtering in y-direction smoothed out the fluctuation due to motion artifacts caused by brain movement, hear beat, or respiratory cycle. The program applies auto contrast algorithm (or two-Gaussian fit to intensity histogram) to create binary profiles of kymographs. The width of the binarized kymographs at each raw (time points) are measured (in pixels) and recorded and exported. In order to evaluate the out-of-focus condition caused by brain motion, the data points that had focus measure shifts (above/below 30%) were excluded in the analysis.</p>
<p><br />Source codes for BloodV10 and KymoHT6 are available as MATLAB GUI format (BloodV10.m and BloodV10.fig; Analyzekymogph2020HT5.m and Analyzekymogph2020HT5.fig).</p>
<p><br />MontageViewer.exe and corresponding MATLAB codes (MontageViewer.m and MontageViewer.fig) are for an additional program to display time-series movie in montage snapshot. </p>
<h2 id="blob-path" class="breadcrumb flex-auto flex-self-center min-width-0 text-normal mx-2 width-full width-md-auto flex-order-1 flex-md-order-none mt-3 mt-md-0">&nbsp;</h2>
