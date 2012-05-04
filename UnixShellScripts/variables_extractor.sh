#!/bin/bash
##
# Here is a script that I've used during some refactoring task, I needed to split a huge JSP page into multiple
# pages and there were variables declarations all around the place, so this script is basically grepping through
# the code to see which variables is going to be neeeded by which page
##
for variable in $(echo '
<c:set var="flightSummaryTitle" value="${ vaa:propertyWithDefault(resource, 'flightsummarytitle', 'Your outbound flight summary') }" />
<c:set var="bookingReferenceLabel" value="${ vaa:propertyWithDefault(resource, 'bookingreference', 'Booking reference') }" />
<c:set var="toLabel" value="${ vaa:propertyWithDefault(resource, 'tolabel', 'to') }" />
<c:set var="flightNumberLabel" value="${ vaa:propertyWithDefault(resource, 'flightnumberlabel', 'Flight No.') }" />
<c:set var="departLabel" value="${ vaa:propertyWithDefault(resource, 'departlabel', 'Depart') }" />
<c:set var="detailsLinkText" value="${ vaa:propertyWithDefault(resource, 'detailslinktext', 'View detailed summary') }" />
<c:set var="daysLabel" value="${ vaa:propertyWithDefault(resource, 'dayslabel', 'Days') }" />
<c:set var="hoursLabel" value="${ vaa:propertyWithDefault(resource, 'hourslabel', 'Hours') }" />
<c:set var="minutesLabel" value="${ vaa:propertyWithDefault(resource, 'minuteslabel', 'Mins to go') }" />
<c:set var="dataRequirementInfo" value="${ vaa:propertyWithDefault(resource, 'dataRequirementInfo', 'We can not fly without you unless we have this info!') }" />
<c:set var="fillInImportantBits" value="${ vaa:propertyWithDefault(resource, 'fillInImportantBits', 'Fill in all the important bits') }" />
<c:set var="makeSureMessage" value="${ vaa:propertyWithDefault(resource, 'makeSureMessage', 'Make sure you are ready to fly') }" />
<c:set var="sectionNumber" value="${ vaa:propertyWithDefault(resource, 'sectionNumber', '01') }" />
<c:set var="contactLabel" value="${ vaa:propertyWithDefault(resource, 'contactlabel', 'Contact') }" />
<c:set var="passengerDetailsHeaderLabel" value="${ vaa:propertyWithDefault(resource, 'passengerDetailsHeaderLabel', 'Passenger details') }" />
<c:set var="informalMessageLabel" value="${ vaa:propertyWithDefault(resource, 'informalMessageLabel', 'The more you tell us, the more helpful we can be.') }" />
<c:set var="correctDetailsQuestionLabel" value="${ vaa:propertyWithDefault(resource, 'correctDetailsQuestionLabel', 'Are your details correct?') }" />
<c:set var="provideDetailsLabel" value="${ vaa:propertyWithDefault(resource, 'provideDetailsLabel', 'Please provide your details for this flight.') }" />
<c:set var="amendIncorrectDetailsInfo" value="${ vaa:propertyWithDefault(resource, 'amendIncorrectDetailsInfo', 'If the name above is incorrect, please call our reservations team on 0844 209 7301 to amend it. There is a fee for this service.') }" />
<c:set var="contactDetailsHeaderLabel" value="${ vaa:propertyWithDefault(resource, 'contactDetailsHeaderLabel', 'Contact details') }" />
<c:set var="contactDetailsRequiredLabel" value="${ vaa:propertyWithDefault(resource, 'contactDetailsRequiredLabel', '*Required information') }" />
<c:set var="anotherContactHomeLabel" value="${ vaa:propertyWithDefault(resource, 'anotherContactHomeLabel', 'Home tel number') }" />
<c:set var="anotherContactBusinessLabel" value="${ vaa:propertyWithDefault(resource, 'anotherContactBusinessLabel', 'Business tel number') }" />
<c:set var="anotherContactOverseasLabel" value="${ vaa:propertyWithDefault(resource, 'anotherContactOverseasLabel', 'Overseas tel number') }" />
<c:set var="emailAddressLabel" value="${ vaa:propertyWithDefault(resource, 'emailAddressLabel', 'Email address') }" />
<c:set var="emergencyContactHeaderLabel" value="${ vaa:propertyWithDefault(resource, 'emergencyContactHeaderLabel', 'Emergency contacts') }" />
<c:set var="emergencyContactNameLabel" value="${ vaa:propertyWithDefault(resource, 'emergencyContactNameLabel', 'Name') }" />
<c:set var="emergencyContactPhoneNumberLabel" value="${ vaa:propertyWithDefault(resource, 'emergencyContactPhoneNumberLabel', 'Contact number') }" />
<c:set var="emergencyContactInfoText" value="${ vaa:propertyWithDefault(resource, 'emergencyContactInfoText', 'We will only use these details to send information related to your flight. It will not be used for marketing, but may be used for research - we value your feedback.') }" />
<c:set var="mobileNumberLabel" value="${ vaa:propertyWithDefault(resource, 'mobileNumberLabel', 'Mobile number') }" />
<c:set var="mobilePhoneNumberCountryLabel" value="${ vaa:propertyWithDefault(resource, 'mobilePhoneNumberCountryLabel', 'This number is local to') }" />
<c:set var="homeNumberCountryLabel" value="${ vaa:propertyWithDefault(resource, 'homePhoneNumberCountryLabel', 'This number is local to') }" />
<c:set var="businessNumberCountryLabel" value="${ vaa:propertyWithDefault(resource, 'businessPhoneNumberCountryLabel', 'This number is local to') }" />
<c:set var="overseasNumberCountryLabel" value="${ vaa:propertyWithDefault(resource, 'overseasPhoneNumberCountryLabel', 'This number is local to') }" />
<c:set var="emergencyPhoneNumberCountryLabel" value="${ vaa:propertyWithDefault(resource, 'emergencyPhoneNumberCountryLabel', 'This number is local to') }" />
<c:set var="phoneNumberCountryDefaultValueLabel" value="${ vaa:propertyWithDefault(resource, 'phoneNumberCountryDefaultValue', 'Select country') }" />
<c:set var="flyingClubHeaderLabel" value="${ vaa:propertyWithDefault(resource, 'flyingClubHeaderLabel', 'Flying Club and loyalty programmes') }" />
<c:set var="flyingClubInfoText" value="${ vaa:propertyWithDefault(resource, 'flyingClubInfoText', 'Make sure you do not miss out on miles, tier points and other rewards for this flight! Enter your membership details to claim what is yours....') }" />
<c:set var="loyaltyProgrammeFieldLabel" value="${ vaa:propertyWithDefault(resource, 'loyaltyProgrammeFieldLabel', 'Loyalty programme') }" />
<c:set var="membershipNumberFieldLabel" value="${ vaa:propertyWithDefault(resource, 'membershipNumberFieldLabel', 'Your membership number') }" />
<c:set var="saveAndContinueButtonLabel" value="${ vaa:propertyWithDefault(resource, 'saveAndContinueButtonLabel', 'Save and continue') }" />
<c:set var="defaultOptionFieldValueLabel" value="${ vaa:propertyWithDefault(resource, 'defaultOptionFieldValueLabel', 'Please select') }" />
<c:set var="enterDetailsLinkText" value="${ vaa:propertyWithDefault(resource, 'enterDetailsLabel', 'Enter details') }" />
<c:set var="hideDetailsLinkText" value="${ vaa:propertyWithDefault(resource, 'hideDetailsLinkText', 'Hide details') }" />
<c:set var="addAnotherContactFieldLabel" value="${ vaa:propertyWithDefault(resource, 'addAnotherContactFieldLabel', 'Add another contact') }" />
<c:set var="removeContactButtonLabel" value="${ vaa:propertyWithDefault(resource, 'removeContactButtonLabel', 'Remove') }" />
<c:set var="flyingClubDefaultOptionFieldValueLabel" value="${ vaa:propertyWithDefault(resource, 'flyingClubDefaultOptionFieldValueLabel', 'Please select') }" />
<c:set var="mealHeaderText" value="${ vaa:propertyWithDefault(resource, 'mealHeaderText', 'Meals') }" />
<c:set var="tooLateInfoText" value="${ vaa:propertyWithDefault(resource, 'tooLateInfoText', 'As its nearly time for your flight its now too late to request a specific meal online. Rest assured, we will still be serving you some tasty food and drink during your journey.') }" />
<c:set var="yourMealText" value="${ vaa:propertyWithDefault(resource, 'yourMealText', 'Your meal') }" />
<c:set var="mealPrefAckText" value="${ vaa:propertyWithDefault(resource, 'mealPrefAckText', 'Your meal request has been acknowledged') }" />
<c:set var="tooLongEmergencyContactNameError" value="${ vaa:propertyWithDefault(resource, 'tooLongEmergencyContactNameError', 'Please enter no more than 58 characters') }" />
<c:set var="tooShortEmergencyContactNameError" value="${ vaa:propertyWithDefault(resource, 'tooShortEmergencyContactNameError', 'Please enter at least 4 characters') }" />
<c:set var="paxDetailsGenericError" value="${ vaa:propertyWithDefault(resource, 'paxDetailsGenericError', 'You are almost there! Check the highlighted areas below to see what went wrong.') }" />
<c:set var="invalidContactPhoneNumberError" value="${ vaa:propertyWithDefault(resource, 'invalidContactPhoneNumberError', 'Please enter a valid contact number') }" />
<c:set var="emptyRegionError" value="${ vaa:propertyWithDefault(resource, 'emptyRegionError', 'Please select a region') }" />
<c:set var="emptyLoyaltyProgrammeError" value="${ vaa:propertyWithDefault(resource, 'emptyLoyaltyProgrammeError', 'Please select a loyalty programme') }" />
<c:set var="emptyMembershipNumberError" value="${ vaa:propertyWithDefault(resource, 'emptyMembershipNumberError', 'Please enter a membership number') }" />
<c:set var="requiredField" value="${ vaa:propertyWithDefault(resource, 'requiredField', 'This field is required') }" />
<c:set var="phoneNumberMaxLength" value="${ vaa:propertyWithDefault(resource, 'homePhoneNumberMaxLength', 'Please enter no more than 30 characters') }" />
<c:set var="overseasPhoneNumberMaxLength" value="${ vaa:propertyWithDefault(resource, 'overseasPhoneNumberMaxLength', 'Please enter no more than 30 characters') }" />
<c:set var="invalidEmailAddressError" value="${ vaa:propertyWithDefault(resource, 'invalidEmailAddressError', 'Please enter no more than 100 characters') }" />
<c:set var="invalidEmergencyContactNameError" value="${ vaa:propertyWithDefault(resource, 'invalidEmergencyContactNameError', 'Please enter a valid contact name') }" />
<c:set var="phoneNumberRequiredField" value="${ vaa:propertyWithDefault(resource, 'phoneNumberRequiredField', 'You have missed a bit. Please provide a number') }" />
<c:set var="homePhoneNumberRequiredField" value="${ vaa:propertyWithDefault(resource, 'homePhoneNumberRequiredField', 'Please provide a number') }" /> 
<c:set var="tooLongEmergencyPhoneNumberError" value="${ vaa:propertyWithDefault(resource, 'tooLongEmergencyPhoneNumberError', 'Please enter no more than 58 characters') }" />
<c:set var="tooShortEmergencyPhoneNumberError" value="${ vaa:propertyWithDefault(resource, 'tooShortEmergencyPhoneNumberError', 'Please enter at least 4 characters') }" />
<c:set var="sectionNumber2Label" value="${ vaa:propertyWithDefault(resource, 'sectionNumber2Label', '02') }" />
<c:set var="customiseExperienceText" value="${ vaa:propertyWithDefault(resource, 'customiseExperienceText', 'Customise your experience') }" />
<c:set var="enjoyTripText" value="${ vaa:propertyWithDefault(resource, 'enjoyTripText', 'Enjoy your trip just the way you like it.') }" />
<c:set var="yourSeatsHeaderLabel" value="${ vaa:propertyWithDefault(resource, 'yourSeatsHeaderLabel', 'Your seats') }" />
<c:set var="yourSeatsTooltipText" value="${ vaa:propertyWithDefault(resource, 'yourSeatsTooltipText', 'Your seats tool tip text') }" />
<c:set var="upgradeTicketLinkStartText" value="${ vaa:propertyWithDefault(resource, 'upgradeTicketLinkStartText', 'Upgrade to Premium Economy for ') }" />
<c:set var="upgradeTicketLinkPriceText" value="${ vaa:propertyWithDefault(resource, 'upgradeTicketLinkPriceText', '150') }" />
<c:set var="upgradeTicketLinkPerPersonText" value="${ vaa:propertyWithDefault(resource, 'upgradeTicketLinkPerPersonText', 'per person') }" />
<c:set var="seatsConfirmedLabel" value="${ vaa:propertyWithDefault(resource, 'seatsConfirmedLabel', 'Confirmed') }" />
<c:set var="passengerSeatsHeaderText" value="${ vaa:propertyWithDefault(resource, 'passengerSeatsHeaderText', 'Where would you like to seat?') }" />
<c:set var="changeSeatsInfoText" value="${ vaa:propertyWithDefault(resource, 'changeSeatsInfoText', 'If you would like to change your seat select a passenger and click on an available seat, or drag and drop your self into your preferred location') }" />
<c:set var="emptySeatsInfoText" value="${ vaa:propertyWithDefault(resource, 'emptySeatsInfoText', 'Empty seats between passengers are not allowed.') }" />
<c:set var="childrenSeatsInfoText" value="${ vaa:propertyWithDefault(resource, 'childrenSeatsInfoText', 'Children under 16 seats can not sit on their own.') }" />
<c:set var="openSeatMapLabel" value="${ vaa:propertyWithDefault(resource, 'openSeatMapLabel', 'Open seatmap') }" />
<c:set var="closeSeatMapLabel" value="${ vaa:propertyWithDefault(resource, 'closeSeatMapLabel', 'Close seatmap') }" />
<c:set var="childLabel" value="${ vaa:propertyWithDefault(resource, 'childLabel', 'Child:') }" />
<c:set var="adultLabel" value="${ vaa:propertyWithDefault(resource, 'adultLabel', 'Adult:') }" />
<c:set var="changeSeatsErrorText" value="${ vaa:propertyWithDefault(resource, 'changeSeatsErrorText', 'The seats you picked are no longer available. Please be quick! We have moved you back to your original seats. Children under 16 must sit next to an adult.') }" />
<c:set var="changeSeatsWarningText" value="${ vaa:propertyWithDefault(resource, 'changeSeatsWarningText', 'While we will allways do our best to sit you according to your preference, seating is subject to change for operational reasons.') }" />' | awk -F "value=" '{print $1}' | awk -F "var=" '{print $2}' | sed 's/"//g')
do
for filename in flightsummary.jsp passengerdetails.jsp seatmap.jsp checkindetails.jsp onlinecheckin.jsp
do
grep -i '${'"${variable}"'}' ${filename} > /dev/null && (echo "${filename}: $(grep ${variable} variables.jsp)")
done
done > final_results.txt