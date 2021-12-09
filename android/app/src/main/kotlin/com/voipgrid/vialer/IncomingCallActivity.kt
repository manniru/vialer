package com.voipgrid.vialer

import android.app.Activity
import android.app.KeyguardManager
import android.content.*
import android.os.Build
import android.os.Bundle
import android.view.Window
import android.view.WindowManager
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.FloatingActionButton
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.TextUnit
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.voipgrid.vialer.Brand.*
import java.util.*
import kotlin.concurrent.schedule

class IncomingCallActivity : ComponentActivity() {

    private val receiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            finish()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        registerReceiver(receiver, IntentFilter(INCOMING_CALL_CANCEL_INTENT))
        requestWindowFeature(Window.FEATURE_NO_TITLE)
        ensureScreenShowsWhilePhoneIsLocked()

        setContent {
            IncomingCallPage(
                callHeaderInformation = CallHeaderInformation(
                    intent.getStringExtra(EXTRA_HEADING) ?: "",
                    intent.getStringExtra(EXTRA_SUBHEADING) ?: "",
                ),
                brand = brandFromPackageName(this),
                onAnswer = { performAction(Action.ANSWER) },
                onDecline = { performAction(Action.DECLINE) },
            )
        }
    }

    /**
     * Determine the current brand based on the package name being used. This is a "hacky" solution
     * until we are able to make Flutter resources available to native.
     *
     */
    private fun brandFromPackageName(context: Context): Brand = values().firstOrNull { brand ->
        context.packageName.contains(brand.name.lowercase())
    } ?: throw Exception("Unable to determine brand from package name")

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(receiver)
    }

    private fun ensureScreenShowsWhilePhoneIsLocked() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(true)
            setTurnScreenOn(true)
        } else {
            // If the phone isn't on SDK >= 27, we have to use the old flags api to show
            // while locked.
            window.addFlags(
                WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
                        or WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD
                        or WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
                        or WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
                        or WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON
            )
        }
    }

    private fun performAction(action: Action) {
        Intent().also {
            it.action = action.name
            it.component = ComponentName(packageName, ACTION_RECEIVER)
            sendBroadcast(it)
        }

        // Provide a fail-safe to kill this activity after the user has pressed a button, just
        // in-case the event isn't received for some reason they won't be stuck on this screen.
        Timer().schedule(3000) {
            if (!isFinishing) {
                finish()
            }
        }
    }

    companion object {
        private const val ACTION_RECEIVER =
            "org.openvoipalliance.androidphoneintegration.service.NotificationButtonReceiver"
        private const val EXTRA_HEADING = "remote_party_heading"
        private const val EXTRA_SUBHEADING = "remote_party_subheading"
        private const val INCOMING_CALL_CANCEL_INTENT =
            "org.openvoipalliance.androidphoneintegration.INCOMING_CALL_CANCEL"
    }

    private enum class Action {
        ANSWER, DECLINE
    }
}

enum class Brand {
    VIALER, VOYS, ANNABEL, VERBONDEN
}

fun Activity.launchIncomingCallScreen(remotePartyHeading: String, remotePartySubheading: String) =
    startActivity(Intent(this, IncomingCallActivity::class.java).apply {
        putExtra("remote_party_heading", remotePartyHeading)
        putExtra("remote_party_subheading", remotePartySubheading)
    })

private val textStyle = TextStyle(color = Color.White)
private lateinit var currentBrand: Brand

private val brandColor: Color by lazy {
    when (currentBrand) {
        VIALER -> Color(0xFFD45400)
        VOYS -> Color(0xFF3B14B9)
        ANNABEL -> Color(0xFF003a63)
        VERBONDEN -> Color(0xFF5F4B8B)
    }
}

private val brandIcon: VialerSans by lazy {
    when (currentBrand) {
        VIALER -> VialerSans.BRAND_VIALER
        VOYS -> VialerSans.BRAND_VOYS
        ANNABEL -> VialerSans.BRAND_ANNABEL
        VERBONDEN -> VialerSans.BRAND_VERBONDEN
    }
}

@Composable
fun IncomingCallPage(
    callHeaderInformation: CallHeaderInformation,
    brand: Brand,
    onAnswer: () -> Unit,
    onDecline: () -> Unit,
) {
    currentBrand = brand

    RadialGradientBackground {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(bottom = 64.dp, top = 88.dp),
            verticalArrangement = Arrangement.SpaceBetween,
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            ConcentricCircleGraphic(size = 250.dp) {
                Icon(
                    icon = brandIcon,
                    size = 60.sp,
                    color = brandColor,
                )
            }

            CallHeader(callHeaderInformation)

            Row(
                Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceAround,
            ) {
                AnswerButton(onAnswer)
                DeclineButton(onDecline)
            }
        }
    }
}

/**
 * A container with a radial gradient as the background. This background is automatically
 * positioned at the top of the screen.
 *
 * @param content
 */
@Composable
fun RadialGradientBackground(content: @Composable() () -> Unit) {
    val configuration = LocalConfiguration.current
    val screenHeight = with(LocalDensity.current) { configuration.screenHeightDp.dp.toPx() }
    val screenWidth = with(LocalDensity.current) { configuration.screenWidthDp.dp.toPx() }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
    ) {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(
                    Brush.radialGradient(
                        0f to brandColor,
                        0.9f to brandColor.copy(alpha = 0.2f),
                        1f to brandColor.copy(alpha = 0.1f),
                        center = Offset((screenWidth / 2), (screenHeight * 0.25).toFloat()),
                        radius = (screenHeight * 0.8).toFloat(),
                    ),
                ),
        ) {
            content()
        }
    }
}

/**
 * Generates a graphic made up of concentric circles with the provided content in the center.
 *
 * @param size The initial size of the graphic.
 * @param layerWidth The size of each individual layer.
 * @param layers The number of layers to generate.
 * @param content The content within the most-inner circle.
 */
@Composable
fun ConcentricCircleGraphic(
    size: Dp,
    layerWidth: Dp = 75.dp,
    layers: Int = 3,
    content: @Composable() () -> Unit,
) {
    Box(
        modifier = Modifier
            .size(size)
            .clip(CircleShape)
            .background(Color.White.copy(alpha = 0.2f)),
        contentAlignment = Alignment.Center,
    ) {
        when {
            layers != 1 -> ConcentricCircleGraphic(
                size = size - layerWidth,
                layers = layers - 1,
                content = content,
            )
            else -> Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.Center,
            ) {
                content()
            }
        }
    }
}

@Composable
fun CallHeader(callHeaderInformation: CallHeaderInformation, fontSize: TextUnit = 22.sp) {
    Column(
        Modifier
            .fillMaxWidth()
            .padding(10.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Avatar(callHeaderInformation = callHeaderInformation)
            Spacer(modifier = Modifier.size(20.dp))
            Column() {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Icon(
                        VialerSans.INCOMING_CALL,
                        size = fontSize * 0.6,
                        color = textStyle.color,
                    )

                    Spacer(modifier = Modifier.padding(horizontal = 4.dp))

                    Text(
                        stringResource(R.string.call_incoming_subtitle),
                        fontSize = fontSize * 0.6,
                        style = textStyle,
                    )
                }

                Text(
                    callHeaderInformation.title,
                    fontWeight = FontWeight.Bold,
                    fontSize = fontSize,
                    style = textStyle,
                )

                Text(
                    callHeaderInformation.subtitle,
                    fontSize = fontSize * 0.8,
                    style = textStyle,
                )
            }
        }
    }
}

/**
 * Generate the text that will appear inside the avatar on the call screen, this will be the
 * initials from the [callHeaderInformation] or if that is not appropriate then the [fallback].
 *
 */
fun generateAvatarContent(
    callHeaderInformation: CallHeaderInformation,
    fallback: String = "#",
): String {
    val title = callHeaderInformation.title

    if (title.isEmpty()) return fallback

    if (!title.first().isLetter()) return fallback

    val words = title.split(" ")

    return when (words.size) {
        1 -> words.first().first().uppercase()
        else -> "${words.first().first().uppercase()}${words.last().first().uppercase()}"
    }
}

@Composable
fun Avatar(callHeaderInformation: CallHeaderInformation) {
    Box(
        modifier = Modifier
            .size(36.dp)
            .clip(CircleShape)
            .background(Color.White),
        contentAlignment = Alignment.Center,
    ) {
        Text(
            generateAvatarContent(callHeaderInformation = callHeaderInformation),
            style = TextStyle(color = brandColor, fontWeight = FontWeight.Bold),
        )
    }
}

@Composable
fun AnswerButton(onClick: () -> Unit) {
    ActionButton(
        onClick = onClick,
        backgroundColor = Color(0xFF28CA42),
        text = stringResource(R.string.notification_answer_action)
    ) {
        Icon(icon = VialerSans.PHONE)
    }
}

@Composable
fun DeclineButton(onClick: () -> Unit) {
    ActionButton(
        onClick = onClick,
        backgroundColor = Color(0xFFDA534F),
        text = stringResource(R.string.notification_decline_action)
    ) {
        Icon(icon = VialerSans.HANG_UP)
    }
}

@Composable
fun Icon(icon: VialerSans, size: TextUnit = 32.sp, color: Color = Color.Unspecified) {
    Text(
        text = String(charArrayOf(icon.character.toChar())),
        fontFamily = FontFamily(Font(R.font.vialer_sans)),
        fontSize = size,
        color = color,
    )
}

@Composable
fun ActionButton(
    onClick: () -> Unit,
    backgroundColor: Color,
    text: String,
    content: @Composable() () -> Unit,
) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Text(
            text.uppercase(),
            modifier = Modifier.padding(bottom = 12.dp),
            style = textStyle.copy(fontWeight = FontWeight.Bold, letterSpacing = 1.sp),
        )
        FloatingActionButton(
            onClick = onClick,
            backgroundColor = backgroundColor,
            contentColor = Color.White,
            modifier = Modifier.size(70.dp),
        ) {
            content()
        }
    }
}

enum class VialerSans(val character: Int) {
    BRAND_VIALER(0xE98A),
    BRAND_VOYS(0xE975),
    BRAND_VERBONDEN(0xE9AB),
    BRAND_ANNABEL(0xE9AA),
    HANG_UP(0xE96B),
    PHONE(0xE980),
    INCOMING_CALL(0xE924),
}

data class CallHeaderInformation(val title: String = "", val subtitle: String = "")