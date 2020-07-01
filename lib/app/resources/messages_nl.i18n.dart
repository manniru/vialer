// GENERATED FILE, do not edit!
import 'package:i18n/i18n.dart' as i18n;
import 'messages.i18n.dart';

String get _languageCode => 'nl';
String get _localeName => 'nl';

String _plural(int count, {String zero, String one, String two, String few, String many, String other}) =>
	i18n.plural(count, _languageCode, zero:zero, one:one, two:two, few:few, many:many, other:other);
String _ordinal(int count, {String zero, String one, String two, String few, String many, String other}) =>
	i18n.ordinal(count, _languageCode, zero:zero, one:one, two:two, few:few, many:many, other:other);
String _cardinal(int count, {String zero, String one, String two, String few, String many, String other}) =>
	i18n.cardinal(count, _languageCode, zero:zero, one:one, two:two, few:few, many:many, other:other);

class Messages_nl extends Messages {
	const Messages_nl();
	GenericMessages_nl get generic => GenericMessages_nl(this);
	MainMessages_nl get main => MainMessages_nl(this);
	OnboardingMessages_nl get onboarding => OnboardingMessages_nl(this);
}

class GenericMessages_nl extends GenericMessages {
	final Messages_nl _parent;
	const GenericMessages_nl(this._parent):super(_parent);
	ButtonGenericMessages_nl get button => ButtonGenericMessages_nl(this);
}

class ButtonGenericMessages_nl extends ButtonGenericMessages {
	final GenericMessages_nl _parent;
	const ButtonGenericMessages_nl(this._parent):super(_parent);
	String get ok => """Ok""";
	String get cancel => """Annuleren""";
}

class MainMessages_nl extends MainMessages {
	final Messages_nl _parent;
	const MainMessages_nl(this._parent):super(_parent);
	CallThroughMainMessages_nl get callThrough => CallThroughMainMessages_nl(this);
	DialerMainMessages_nl get dialer => DialerMainMessages_nl(this);
	RecentMainMessages_nl get recent => RecentMainMessages_nl(this);
	ContactsMainMessages_nl get contacts => ContactsMainMessages_nl(this);
	SettingsMainMessages_nl get settings => SettingsMainMessages_nl(this);
}

class CallThroughMainMessages_nl extends CallThroughMainMessages {
	final MainMessages_nl _parent;
	const CallThroughMainMessages_nl(this._parent):super(_parent);
	ErrorCallThroughMainMessages_nl get error => ErrorCallThroughMainMessages_nl(this);
}

class ErrorCallThroughMainMessages_nl extends ErrorCallThroughMainMessages {
	final CallThroughMainMessages_nl _parent;
	const ErrorCallThroughMainMessages_nl(this._parent):super(_parent);
	String get title => """Er is een fout opgetreden""";
	String get unknown => """Onbekende error.""";
	String get invalidDestination => """Het nummer klopt niet.""";
}

class DialerMainMessages_nl extends DialerMainMessages {
	final MainMessages_nl _parent;
	const DialerMainMessages_nl(this._parent):super(_parent);
	String get title => """Telefoon""";
	String get permissionDenied => """Er is geen permissie om te bellen, wat nodig is om via de app te bellen.""";
	MenuDialerMainMessages_nl get menu => MenuDialerMainMessages_nl(this);
	ConfirmDialerMainMessages_nl get confirm => ConfirmDialerMainMessages_nl(this);
}

class MenuDialerMainMessages_nl extends MenuDialerMainMessages {
	final DialerMainMessages_nl _parent;
	const MenuDialerMainMessages_nl(this._parent):super(_parent);
	String get title => """Telefoon""";
}

class ConfirmDialerMainMessages_nl extends ConfirmDialerMainMessages {
	final DialerMainMessages_nl _parent;
	const ConfirmDialerMainMessages_nl(this._parent):super(_parent);
	String title(String appName) => """$appName Gesprek""";
	DescriptionConfirmDialerMainMessages_nl get description => DescriptionConfirmDialerMainMessages_nl(this);
	ButtonConfirmDialerMainMessages_nl get button => ButtonConfirmDialerMainMessages_nl(this);
}

class DescriptionConfirmDialerMainMessages_nl extends DescriptionConfirmDialerMainMessages {
	final ConfirmDialerMainMessages_nl _parent;
	const DescriptionConfirmDialerMainMessages_nl(this._parent):super(_parent);
	String get origin => """Er wordt gebeld met je zakelijke nummer""";
	String main(String appName) => """$appName verbindt je gesprek door,\nwaardoor je persoonlijke nummer privé blijft""";
	String get action => """Klik op de “Bel” knop om het volgende nummer te bellen:""";
}

class ButtonConfirmDialerMainMessages_nl extends ButtonConfirmDialerMainMessages {
	final ConfirmDialerMainMessages_nl _parent;
	const ButtonConfirmDialerMainMessages_nl(this._parent):super(_parent);
	String call(String number) => """Bel $number""";
}

class RecentMainMessages_nl extends RecentMainMessages {
	final MainMessages_nl _parent;
	const RecentMainMessages_nl(this._parent):super(_parent);
	String get title => """Recente gesprekken""";
	MenuRecentMainMessages_nl get menu => MenuRecentMainMessages_nl(this);
	SnackBarRecentMainMessages_nl get snackBar => SnackBarRecentMainMessages_nl(this);
	ListRecentMainMessages_nl get list => ListRecentMainMessages_nl(this);
}

class MenuRecentMainMessages_nl extends MenuRecentMainMessages {
	final RecentMainMessages_nl _parent;
	const MenuRecentMainMessages_nl(this._parent):super(_parent);
	String get title => """Recent""";
}

class SnackBarRecentMainMessages_nl extends SnackBarRecentMainMessages {
	final RecentMainMessages_nl _parent;
	const SnackBarRecentMainMessages_nl(this._parent):super(_parent);
	String get copied => """Nummer gekopieerd""";
}

class ListRecentMainMessages_nl extends ListRecentMainMessages {
	final RecentMainMessages_nl _parent;
	const ListRecentMainMessages_nl(this._parent):super(_parent);
	String minuteAgo() => """1 minuut geleden""";
	String minutesAgo(int minutes) => """$minutes minuten geleden""";
	String hourAgo() => """1 uur geleden""";
	String hoursAgo(int hours) => """$hours uren geleden""";
	PopupMenuListRecentMainMessages_nl get popupMenu => PopupMenuListRecentMainMessages_nl(this);
	EmptyListRecentMainMessages_nl get empty => EmptyListRecentMainMessages_nl(this);
}

class PopupMenuListRecentMainMessages_nl extends PopupMenuListRecentMainMessages {
	final ListRecentMainMessages_nl _parent;
	const PopupMenuListRecentMainMessages_nl(this._parent):super(_parent);
	String get copy => """Kopiëren""";
	String get call => """Bellen""";
}

class EmptyListRecentMainMessages_nl extends EmptyListRecentMainMessages {
	final ListRecentMainMessages_nl _parent;
	const EmptyListRecentMainMessages_nl(this._parent):super(_parent);
	String get title => """Geen recente activiteit""";
	String get description => """Er is geen recente gespreks activiteit om te tonen. Zodra je iemand belt of zelf gebeld wordt, zal het hier verschijnen.""";
}

class ContactsMainMessages_nl extends ContactsMainMessages {
	final MainMessages_nl _parent;
	const ContactsMainMessages_nl(this._parent):super(_parent);
	String get title => """Contacten""";
	MenuContactsMainMessages_nl get menu => MenuContactsMainMessages_nl(this);
	ListContactsMainMessages_nl get list => ListContactsMainMessages_nl(this);
}

class MenuContactsMainMessages_nl extends MenuContactsMainMessages {
	final ContactsMainMessages_nl _parent;
	const MenuContactsMainMessages_nl(this._parent):super(_parent);
	String get title => """Contacten""";
}

class ListContactsMainMessages_nl extends ListContactsMainMessages {
	final ContactsMainMessages_nl _parent;
	const ListContactsMainMessages_nl(this._parent):super(_parent);
	EmptyListContactsMainMessages_nl get empty => EmptyListContactsMainMessages_nl(this);
	NoPermissionListContactsMainMessages_nl get noPermission => NoPermissionListContactsMainMessages_nl(this);
	ItemListContactsMainMessages_nl get item => ItemListContactsMainMessages_nl(this);
}

class EmptyListContactsMainMessages_nl extends EmptyListContactsMainMessages {
	final ListContactsMainMessages_nl _parent;
	const EmptyListContactsMainMessages_nl(this._parent):super(_parent);
	String get title => """Geen contacten gevonden""";
	String get description => """Vialer kon geen contacten vinden op je telefoon. Wanneer je een contact aanmaakt zijn te zien in Vialer.""";
}

class NoPermissionListContactsMainMessages_nl extends NoPermissionListContactsMainMessages {
	final ListContactsMainMessages_nl _parent;
	const NoPermissionListContactsMainMessages_nl(this._parent):super(_parent);
	String get title => """Geen toegang tot contacten""";
	String get description => """Vialer heeft toestemming nodig om bij je contacten te komen en ze te tonen.""";
	String get button => """Geef toestemming""";
}

class ItemListContactsMainMessages_nl extends ItemListContactsMainMessages {
	final ListContactsMainMessages_nl _parent;
	const ItemListContactsMainMessages_nl(this._parent):super(_parent);
	String get noNumber => """Geen nummer""";
	String numbers(int count) => """$count ${_plural(count, one: 'nummer', many: 'nummers')}""";
	String emails(int count) => """$count ${_plural(count, one: 'email', many: 'emails')}""";
}

class SettingsMainMessages_nl extends SettingsMainMessages {
	final MainMessages_nl _parent;
	const SettingsMainMessages_nl(this._parent):super(_parent);
	String get title => """Instellingen""";
	MenuSettingsMainMessages_nl get menu => MenuSettingsMainMessages_nl(this);
	ListSettingsMainMessages_nl get list => ListSettingsMainMessages_nl(this);
	ButtonsSettingsMainMessages_nl get buttons => ButtonsSettingsMainMessages_nl(this);
	FeedbackSettingsMainMessages_nl get feedback => FeedbackSettingsMainMessages_nl(this);
}

class MenuSettingsMainMessages_nl extends MenuSettingsMainMessages {
	final SettingsMainMessages_nl _parent;
	const MenuSettingsMainMessages_nl(this._parent):super(_parent);
	String get title => """Instellingen""";
}

class ListSettingsMainMessages_nl extends ListSettingsMainMessages {
	final SettingsMainMessages_nl _parent;
	const ListSettingsMainMessages_nl(this._parent):super(_parent);
	DebugListSettingsMainMessages_nl get debug => DebugListSettingsMainMessages_nl(this);
	String get version => """Versie""";
}

class DebugListSettingsMainMessages_nl extends DebugListSettingsMainMessages {
	final ListSettingsMainMessages_nl _parent;
	const DebugListSettingsMainMessages_nl(this._parent):super(_parent);
	String get title => """Debug""";
	RemoteLoggingDebugListSettingsMainMessages_nl get remoteLogging => RemoteLoggingDebugListSettingsMainMessages_nl(this);
}

class RemoteLoggingDebugListSettingsMainMessages_nl extends RemoteLoggingDebugListSettingsMainMessages {
	final DebugListSettingsMainMessages_nl _parent;
	const RemoteLoggingDebugListSettingsMainMessages_nl(this._parent):super(_parent);
	String get title => """Remote logging""";
	String get description => """Deel automatisch je handelingen in de app met onze ontwikkelaars om problemen en fouten op te sporen.""";
}

class ButtonsSettingsMainMessages_nl extends ButtonsSettingsMainMessages {
	final SettingsMainMessages_nl _parent;
	const ButtonsSettingsMainMessages_nl(this._parent):super(_parent);
	String get sendFeedback => """Feedback sturen""";
	String get logout => """Uitloggen""";
}

class FeedbackSettingsMainMessages_nl extends FeedbackSettingsMainMessages {
	final SettingsMainMessages_nl _parent;
	const FeedbackSettingsMainMessages_nl(this._parent):super(_parent);
	String get title => """Feedback""";
	PlaceholdersFeedbackSettingsMainMessages_nl get placeholders => PlaceholdersFeedbackSettingsMainMessages_nl(this);
	String get snackBar => """Feedback verstuurd""";
	ButtonsFeedbackSettingsMainMessages_nl get buttons => ButtonsFeedbackSettingsMainMessages_nl(this);
}

class PlaceholdersFeedbackSettingsMainMessages_nl extends PlaceholdersFeedbackSettingsMainMessages {
	final FeedbackSettingsMainMessages_nl _parent;
	const PlaceholdersFeedbackSettingsMainMessages_nl(this._parent):super(_parent);
	String get title => """Titel""";
	String get text => """Vul hier je feedback in""";
}

class ButtonsFeedbackSettingsMainMessages_nl extends ButtonsFeedbackSettingsMainMessages {
	final FeedbackSettingsMainMessages_nl _parent;
	const ButtonsFeedbackSettingsMainMessages_nl(this._parent):super(_parent);
	String get send => """Feedback sturen""";
}

class OnboardingMessages_nl extends OnboardingMessages {
	final Messages_nl _parent;
	const OnboardingMessages_nl(this._parent):super(_parent);
	ButtonOnboardingMessages_nl get button => ButtonOnboardingMessages_nl(this);
	InitialOnboardingMessages_nl get initial => InitialOnboardingMessages_nl(this);
	LoginOnboardingMessages_nl get login => LoginOnboardingMessages_nl(this);
	PasswordOnboardingMessages_nl get password => PasswordOnboardingMessages_nl(this);
	PermissionOnboardingMessages_nl get permission => PermissionOnboardingMessages_nl(this);
	VoicemailOnboardingMessages_nl get voicemail => VoicemailOnboardingMessages_nl(this);
	WelcomeOnboardingMessages_nl get welcome => WelcomeOnboardingMessages_nl(this);
}

class ButtonOnboardingMessages_nl extends ButtonOnboardingMessages {
	final OnboardingMessages_nl _parent;
	const ButtonOnboardingMessages_nl(this._parent):super(_parent);
	String get login => """Inloggen""";
}

class InitialOnboardingMessages_nl extends InitialOnboardingMessages {
	final OnboardingMessages_nl _parent;
	const InitialOnboardingMessages_nl(this._parent):super(_parent);
	String get title => """Zakelijke\nprivé gesprekken""";
	String get description => """Privé bellen met je zakelijk\nnummer heeft zojuist een upgrade gekregen""";
}

class LoginOnboardingMessages_nl extends LoginOnboardingMessages {
	final OnboardingMessages_nl _parent;
	const LoginOnboardingMessages_nl(this._parent):super(_parent);
	String get title => """Inloggen""";
	PlaceholderLoginOnboardingMessages_nl get placeholder => PlaceholderLoginOnboardingMessages_nl(this);
	ButtonLoginOnboardingMessages_nl get button => ButtonLoginOnboardingMessages_nl(this);
	ErrorLoginOnboardingMessages_nl get error => ErrorLoginOnboardingMessages_nl(this);
}

class PlaceholderLoginOnboardingMessages_nl extends PlaceholderLoginOnboardingMessages {
	final LoginOnboardingMessages_nl _parent;
	const PlaceholderLoginOnboardingMessages_nl(this._parent):super(_parent);
	String get username => """Gebruikersnaam""";
	String get password => """Wachtwoord""";
}

class ButtonLoginOnboardingMessages_nl extends ButtonLoginOnboardingMessages {
	final LoginOnboardingMessages_nl _parent;
	const ButtonLoginOnboardingMessages_nl(this._parent):super(_parent);
	String get forgotPassword => """Wachtwoord vergeten""";
}

class ErrorLoginOnboardingMessages_nl extends ErrorLoginOnboardingMessages {
	final LoginOnboardingMessages_nl _parent;
	const ErrorLoginOnboardingMessages_nl(this._parent):super(_parent);
	String get wrongCombination => """Onjuiste gebruikersnaam & wachtwoord combinatie. Check je login gegevens en probeer het opnieuw.""";
}

class PasswordOnboardingMessages_nl extends PasswordOnboardingMessages {
	final OnboardingMessages_nl _parent;
	const PasswordOnboardingMessages_nl(this._parent):super(_parent);
	String get title => """Wachtwoord veranderen""";
	String get button => """Verander""";
}

class PermissionOnboardingMessages_nl extends PermissionOnboardingMessages {
	final OnboardingMessages_nl _parent;
	const PermissionOnboardingMessages_nl(this._parent):super(_parent);
	ButtonPermissionOnboardingMessages_nl get button => ButtonPermissionOnboardingMessages_nl(this);
	CallPermissionOnboardingMessages_nl get call => CallPermissionOnboardingMessages_nl(this);
	ContactsPermissionOnboardingMessages_nl get contacts => ContactsPermissionOnboardingMessages_nl(this);
}

class ButtonPermissionOnboardingMessages_nl extends ButtonPermissionOnboardingMessages {
	final PermissionOnboardingMessages_nl _parent;
	const ButtonPermissionOnboardingMessages_nl(this._parent):super(_parent);
	String get iUnderstand => """Ik begrijp het""";
}

class CallPermissionOnboardingMessages_nl extends CallPermissionOnboardingMessages {
	final PermissionOnboardingMessages_nl _parent;
	const CallPermissionOnboardingMessages_nl(this._parent):super(_parent);
	String get title => """Bel permissie""";
	String get description => """Deze permissie is nodig om te bellen met de standaard telefoon app.""";
}

class ContactsPermissionOnboardingMessages_nl extends ContactsPermissionOnboardingMessages {
	final PermissionOnboardingMessages_nl _parent;
	const ContactsPermissionOnboardingMessages_nl(this._parent):super(_parent);
	String get title => """Toestemming contactenlijst""";
	String get description => """Deze toestemming zorgt ervoor dat Vialer informatie zoals de contactenlijst en gespreksactiviteit inzichtelijk maakt.\n\nDeze data wordt enkel gebruikt voor het tonen en doorzoeken hiervan.""";
}

class VoicemailOnboardingMessages_nl extends VoicemailOnboardingMessages {
	final OnboardingMessages_nl _parent;
	const VoicemailOnboardingMessages_nl(this._parent):super(_parent);
	String get title => """Voicemail""";
	String get description => """Als je niet een gepersonaliseerde voicemail hebt, kan het zijn dat je persoonlijke nummer wordt genoemd in de voice mail. Mensen die jouw zakelijk nummer bellen kunnen dan je persoonlijke nummer achterhalen.""";
}

class WelcomeOnboardingMessages_nl extends WelcomeOnboardingMessages {
	final OnboardingMessages_nl _parent;
	const WelcomeOnboardingMessages_nl(this._parent):super(_parent);
	String get title => """Welkom""";
}

