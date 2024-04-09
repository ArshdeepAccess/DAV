'use strict';

// Set client auth mode - true to enable client auth, false to disable it
const isClientAuthEnabled = false;

/**
 * Initializes the SDK and sets a global field with passed name for it the can
 * be referred later
 *
 * @param {string} name Name by which the chat widget should be referred
 */
const initSdk = (name) => {
    if (!name) {
        name = 'Bots';          // Set default reference name to 'Bots'
    }
    let Bots;

    setTimeout(() => {
        /**
         * SDK configuration settings
         * Other than URI, all fields are optional with two exceptions for auth modes
         * In client auth disabled mode, 'channelId' must be passed, 'userId' is optional
         * In client auth enabled mode, 'clientAuthEnabled: true' must be passed
         */
        let chatWidgetSettings = {
            URI: 'oda-72bd81079de1463ba56334716b6c4f3f-da12.data.digitalassistant.oci.oraclecloud.com', // ODA URI, only the hostname part should be passed, without the https://
            clientAuthEnabled: isClientAuthEnabled,     // Enables client auth enabled mode of connection if set true
            channelId: '094d95f8-b19b-449d-a198-b5463d5dd0d1',  // Channel ID, available in channel settings in ODA UI
            enableAutocomplete: true,
            displayActionsAsPills: true,                // Enables autocomplete suggestions on user input
            enableBotAudioResponse: false,               // Enables audio utterance of skill responses
            enableClearMessage: true,
            disablePastActions: 'all',                   // Enables display of button to clear conversation
            enableSpeech: false,                         // Enables voice recognition
            enableTimestamp: false,
            enableAttachment: false,                    // Show timestamp with each message
            speechLocale: WebSDK.SPEECH_LOCALE.EN_US,   // Sets locale used to speak to the skill, the SDK supports EN_US, FR_FR, and ES_ES locales for speech
            showConnectionStatus: true,                 // Displays current connection status on the header
            locale: 'en-us',
            i18n: {                                     // Provide translations for the strings used in the widget
                en: {                                   // en locale, can be configured for any locale
                    chatTitle: 'Hi! I am VAYU(ß3.0) ',
                    chatSubtitle: "Virtual Assistant for Your Use"   // Set title at chat header
                },
				linkHandler: { target: 'oda-chat-webview'}
            },

            //BAS.Q.2 Implement Bot Initiated Conversation
            //initUserHiddenMessage : 'Hello',#A10047
            colors: {"branding": "#01D5FA", "text": "#212121", "textLight": "#f4f4f4","headerBackground": "#01D5FA","botMessageBackground":"#f4f4f4","userMessageBackground":"#01D5FA","userText":"#fff","botText":"#424242",
            "actionsBackground": "#01D5FA","actionsBackgroundHover":"#01D5FA","cardNavButtonHover":"#01D5FA"
            },
            height: '500px',
            //BAS.Q.3 Change the chat icons and the icons displayed on the chat header and the message window.
			 ///botButtonIcon : 'http://10.1.1.178:16200/cs/groups/public/documents/document/xzq0/mda0/~edisp/access_ords_44004801.png',
            ///botButtonIcon : $v('P0_IMAGE_URL')+'assets/images/chat3.png',
			///botButtonIcon :'https://icecube-eu-286.icedrive.io/download?p=0xWhHJbflhPbm_BjtP9RwfTOr5i.qfdniIC2Gyu2kjE.6B.UCVK7tys1bx7StP5CG1gkLBO2.6hLFzgmxNYL.XIcNU0ipHTGWDRVpkVixr8luIRul_mAa.Qzx7z0Iu9OucWOaoKSok0IGE49O9XGyPnPwjZiHmCx38fwjlT1doht0EdnQejk0vCCaYIut8Zlg',
			botButtonIcon :'/i/CHATBOT/chat3.png',
            logoIcon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Badge_of_the_Indian_Air_Force.svg/1200px-Badge_of_the_Indian_Air_Force.svg.png',
            personIcon: "https://objectstorage.ap-mumbai-1.oraclecloud.com/n/pnbcloud/b/DBD_PROD_BUCKET/o/images/personIcon.png",
            botIcon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Badge_of_the_Indian_Air_Force.svg/1200px-Badge_of_the_Indian_Air_Force.svg.png',
            skillVoices: [{
                lang: 'en-US',
                name: 'Samantha'
            }],
            embeddedVideo: true,
            initUserHiddenMessage: "hi",
            theme: WebSDK.THEME.CLASSIC,            // Redwood dark theme. The default is THEME.DEFAULT, while older theme is available as THEME.CLASSIC
            chatBubbleIconHeight: "42px",
            chatBubbleIconWidth: "56px",
            inputPlaceholder: "Type a message...",
            messagePadding: "9px",
            position: {
                bottom: '50px',
                right: '50px'
            },
            // CUSTOM UI
            targetElement: 'notification-badge',
            customHeaderElementId: 'header-custom-element',
            embedTopStickyId: 'top-text',
        };

        // Initialize SDK
        if (isClientAuthEnabled) {
            Bots = new WebSDK(chatWidgetSettings, generateToken);
        } else {
            Bots = new WebSDK(chatWidgetSettings);
        }

        // Optional event listeners
        // All event listeners should preferably added before the connect() call, otherwise they may not be fired correctly
        Bots.on(WebSDK.EVENT.CLICK_AUDIO_RESPONSE_TOGGLE, (state) => {
            console.log('Response utterance toggled, current status =', state);
        });

        Bots.on(WebSDK.EVENT.WIDGET_OPENED, () => {
            console.log('Widget is opened');
        });
        // Connect to the ODA
        Bots.connect();

        // Disable the banner section when a message is typed by the user.
        Bots.on('message', function(message) {
            document.getElementById("top-text").style.display = "none";
            document.getElementById("chat_widget_main").style.visibility = "visible";
        });

        // Destroy Chat Window
        Bots.on('destroy', function() {
            console.log('the widget is destroyed!');
        });

        // INT.Q.8 : Optimize longer bot messages displayed in the Oracle Web Messenger
        // Setup a Delegate.


        // Create global object to refer Bots
        window[name] = Bots;
    }, 0);
};
