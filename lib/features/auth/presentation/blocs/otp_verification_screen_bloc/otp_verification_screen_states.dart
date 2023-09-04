abstract class OtpVerificationScreenStates {}

class OtpVerificationInitialState extends OtpVerificationScreenStates {}

class OtpVerifyingState extends OtpVerificationScreenStates {}

class OtpVerificationSuccessState extends OtpVerificationScreenStates {}

class OtpVerificationErrorState extends OtpVerificationScreenStates {}

class ResendingOtpSuccessState extends OtpVerificationScreenStates {}

class ResendingOtpState extends OtpVerificationScreenStates {}

class ResendingOtpErrorState extends OtpVerificationScreenStates {}
