//start of vars.pde
//this file is just a mass of global vars
PShader shadowShader;
PShader depthBufferShader;

PGraphics shadowMap, cameraMatrixMap;
PGraphics[] subShadowMaps = new PGraphics[4];

PImage uvTester;
PImage CBi;

PShape coin3D;
PShape redArrow;
PShape greenArrow;
PShape blueArrow;
PShape yellowArrow;
PShape redScaler;
PShape greenScaler;
PShape blueScaler;
PShape yellowScaler;
PShape LevelCreatorLogo;
PShape rotateCircleX;
PShape rotateCircleY;
PShape rotateCircleZ;
PShape rotateCircleHilight;

boolean requestDepthBufferInit = false ;
boolean showDepthBuffer = false;
boolean shadowShaderOutputSampledDepthInfo = false;
boolean menue = true;
boolean inGame = false;
boolean player1_moving_right = false;
boolean player1_moving_left = false;
boolean dev_mode = false;
boolean player1_jumping = false;
boolean dead = false;
boolean level_complete = false;
boolean reset_spawn = false;
boolean E_pressed = false;
boolean loopThread2 = true;
boolean prevousInGame = false;
boolean setPlayerPosTo = false;
boolean e3DMode = false;
boolean checkpointIn3DStage = false;
boolean WPressed = false;
boolean SPressed = false;
boolean levelCompleteSoundPlayed = false;
boolean tutorialMode = false;
boolean UGC_lvl = false;
boolean levelCompatible = false;
boolean editingBlueprint = false;
boolean viewingItemContents = false;
boolean selecting = false;
boolean s3D = false;
boolean w3D = false;
boolean shift3D = false;
boolean space3D = false;
boolean d3D = false;
boolean a3D = false;
boolean cam_down = false;
boolean cam_up = false;
boolean cam_right = false;
boolean cam_left = false;
boolean isHost = false;
boolean multiplayer = false;
boolean clientQuitting = false;
boolean waitingForReady = false;
boolean loaded = false;
boolean reachedEnd = false;
boolean editingStage = false;
boolean simulating = false;
boolean deleteing = false;
boolean moving_player = false;
boolean grid_mode = false;
boolean drawingPortal = false;
boolean selectingBlueprint = false;
boolean editinglogicBoard = false;
boolean connectingLogic = false;
boolean moveLogicComponents = false;
boolean saveColors = false;
boolean levelOverview = false;
boolean drawingPortal3 = false;
boolean settingPlayerSpawn = false;
boolean levelCreator = false;
boolean drawing = false;
boolean draw = false;
boolean delete = false;
boolean translateXaxis = false;
boolean translateYaxis = false;
boolean translateZaxis = false;
boolean drawingPortal2 = false;
boolean startup = false;
boolean loading = false;
boolean newLevel = false;
boolean newFile = false;
boolean creatingNewBlueprint = false;
boolean loadingBlueprint = false;
boolean coursor = false;
boolean connecting = false;
boolean movingLogicComponent = false;
boolean exitLevelCreator = false;
boolean levelNotFound = false;
boolean transitioningMenu = false;
boolean newSoundAsNarration = false;
boolean newBlueprintIs3D = false;
boolean placingGoon = false;
boolean rotating = false;
ArrayList<Boolean> compatibles;
ArrayList<Boolean> coins;

PVector lightDir = new PVector();
PVector currentComponentRotation = new PVector();

String Menue = "creds";
String version = "0.10.0_Early_Access";
String EDITOR_version = "0.3.0_EAc";
String ip = "localhost";
String name = "can't_be_botherd_to_chane_it";
String rootPath;
String settingsMenue = "game play";
String author = "";
String displayText = "";
String GAME_version = version;
String internetVersion;
String cursor = "";
String disconnectReason = "";
String multyplayerSelectionLevels = "speed";
String multyplayerSelectedLevelPath;
String appdata;
String coursorr = "";
String new_name;
String newFileType = "2D";
String fileToCoppyPath = "";
String defaultAuthor = "can't be botherd to change it";
ArrayList<String> UGCNames = new ArrayList<>();
ArrayList<String> playerNames=new ArrayList<>();

//String[] musicTracks ={"data/music/track1.wav", "data/music/track2.wav", "data/music/track3.wav"};
//String[] sfxTracks={"data/sounds/level complete.wav"};
String[] compatibleVersions={"0.10.0_Early_Access"};

float Scale;
float gravity = 0.001;
float downX;
float downY;
float upX;
float upY;
float blueprintPlacemntX;
float blueprintPlacemntY;
float blueprintPlacemntZ;

float[] tpCords = new float[3];
float[] blueprintMax = new float[3];
float[] blueprintMin = new float[3];

int camPos = 0;
int camPosY = 0;
int death_cool_down;
int start_down;
int port = 9367;
int scroll_left;
int scroll_right;
int respawnX = 20;
int respawnY = 700;
int respawnZ = 150;
int spdelay = 0;
int respawnStage;
int stageIndex;
int coinCount = 0;
int setPlayerPosX;
int setPlayerPosY;
int setPlayerPosZ;
int gmillis = 0;
int coinRotation = 0;
int currentStageIndex;
int tutorialDrawLimit = 0;
int displayTextUntill = 0;
int tutorialPos = 0;
int currentTutorialSound;
int UGC_lvl_indx;
int selectedIndex = -1;
int viewingItemIndex = -1;
int drawCamPosX = 0;
int drawCamPosY = 0;
int currentPlayer = 0;
int currentNumberOfPlayers = 10;
int startTime;
int bestTime = 0;
int sessionTime = 600000;
int timerEndTime;
int startingDepth = 0;
int totalDepth = 300;
int grid_size = 10;
int current3DTransformMode = 1;
int currentBluieprintIndex = 0;
int logicBoardIndex = 0;
int Color = 0;
int RedPos = 0;
int BluePos = 0;
int GreenPos = 0;
int RC = 0;
int GC = 0;
int BC = 0;
int triangleMode = 0;
int transformComponentNumber = 0;
int preSI = 0;
int overviewSelection = -1;
int filesScrole = 0;
int connectingFromIndex = 0;
int movingLogicIndex = 0;
int loadProgress = 0;
int totalLoad = 55;
int curMills = 0;
int lasMills = 0;
int mspc = 0;
int[][] tutorialNarration=new int[2][17];

JSONArray colors;
JSONArray levelProgress;
JSONArray scolors;

JSONObject portalStage1;
JSONObject portalStage2;

Settings settings;

Button shadows0;
Button shadows1;
Button shadows2;
Button shadows3;
Button shadows4;
Button select_lvl_1;
Button select_lvl_back;
Button select_lvl_2;
Button select_lvl_3;
Button select_lvl_4;
Button select_lvl_5;
Button select_lvl_6;
Button sdSlider;
Button enableFPS;
Button disableFPS;
Button enableDebug;
Button disableDebug;
Button sttingsGPL;
Button settingsDSP;
Button settingsOUT;
Button rez720;
Button rez900;
Button rez1080;
Button rez1440;
Button rez4k;
Button fullScreenOn;
Button fullScreenOff;
Button vsdSlider;
Button MusicSlider;
Button SFXSlider;
Button narrationMode1;
Button narrationMode0;
Button select_lvl_UGC;
Button UGC_open_folder;
Button UGC_lvls_next;
Button UGC_lvls_prev;
Button UGC_lvl_play;
Button levelcreatorLink;
Button select_lvl_7;
Button select_lvl_8;
Button select_lvl_9;
Button select_lvl_10;
Button playButton;
Button joinButton;
Button settingsButton;
Button howToPlayButton;
Button exitButton;
Button downloadUpdateButton;
Button updateGetButton;
Button updateOkButton;
Button dev_main;
Button dev_quit;
Button dev_levels;
Button dev_tutorial;
Button dev_settings;
Button dev_UGC;
Button dev_multiplayer;
Button dev_levelCreator;
Button dev_testLevel;
Button multyplayerJoin;
Button multyplayerHost;
Button multyplayerExit;
Button multyplayerGo;
Button multyplayerLeave;
Button multyplayerSpeedrun;
Button multyplayerCoop;
Button multyplayerUGC;
Button multyplayerPlay;
Button increaseTime;
Button decreaseTime;
Button pauseRestart;
Button newLevelButton;
Button loadLevelButton;
Button newStage;
Button newFileCreate;
Button newFileBack;
Button edditStage;
Button setMainStage;
Button selectStage;
Button new2DStage;
Button new3DStage;
Button overview_saveLevel;
Button help;
Button newBlueprint;
Button loadBlueprint;
Button createBlueprintGo;
Button addSound;
Button overviewUp;
Button overviewDown;
Button chooseFileButton;
Button lcLoadLevelButton;
Button lcNewLevelButton;
Button lc_backButton;
Button lcOverviewExitButton;
Button lc_exitConfirm;
Button lc_exitCancle;
Button lc_openLevelsFolder;
Button settingsBackButton;
Button pauseResumeButton;
Button pauseOptionsButton;
Button pauseQuitButton;
Button endOfLevelButton;
Button select_lvl_11;
Button select_lvl_12;
Button settingsSND;
Button lc_newSoundAsSoundButton;
Button lc_newSoundAsNarrationButton;
Button disableMenuTransistionsButton;
Button enableMenuTransitionButton;
Button select_lvl_13;
Button select_lvl_14;
Button select_lvl_15;
Button select_lvl_16;
Button select_lvl_next;

UiFrame ui;

UiText mm_title;
UiText mm_EarlyAccess;
UiText mm_version;
UiText ls_levelSelect;
UiText lsUGC_title;
UiText lsUGC_noLevelFound;
UiText lsUGC_levelNotCompatible;
UiText lsUGC_levelName;
UiText st_title;
UiText st_Hssr;
UiText st_Vssr;
UiText st_gameplay;
UiText st_vsrp;
UiText st_hsrp;
UiText st_gmp_fovdesc;
UiText st_gmp_fovdisp;
UiText st_dsp_vsr;
UiText st_dsp_fs;
UiText st_dsp_4k;
UiText st_dsp_1440;
UiText st_dsp_1080;
UiText st_dsp_900;
UiText st_dsp_720;
UiText st_dsp_fsYes;
UiText st_dsp_fsNo;
UiText st_display;
UiText st_o_displayFPS;
UiText st_o_debugINFO;
UiText st_snd_musicVol;
UiText st_snd_SFXvol;
UiText st_o_3DShadow;
UiText st_snd_narration;
UiText st_o_yes;
UiText st_o_no;
UiText st_o_shadowsOff;
UiText st_o_shadowsOld;
UiText st_o_shadowsLow;
UiText st_o_shadowsMedium;
UiText st_o_shadowsHigh;
UiText st_snd_better;
UiText st_snd_demonitized;
UiText st_snd_currentMusicVolume;
UiText st_snd_currentSoundsVolume;
UiText st_other;
UiText initMultyplayerScreenTitle;
UiText mp_hostSeccion;
UiText mp_host_Name;
UiText mp_host_port;
UiText mp_joinSession;
UiText mp_join_name;
UiText mp_join_port;
UiText mp_join_ip;
UiText mp_disconnected;
UiText mp_dc_reason;
UiText dev_title;
UiText dev_info;
UiText tut_notToday;
UiText tut_disclaimer;
UiText tut_toClose;
UiText coinCountText;
UiText pa_title;
UiText logoText;
UiText up_title;
UiText up_info;
UiText up_wait;
UiText lc_start_version;
UiText lc_start_author;
UiText lc_load_new_describe;
UiText lc_load_notFound;
UiText lc_newf_fileName;
UiText lc_dp2_info;
UiText lc_newbp_describe;
UiText lc_exit_question;
UiText lc_exit_disclaimer;
UiText deadText;
UiText fpsText;
UiText dbg_mspc;
UiText dbg_playerX;
UiText dbg_playerY;
UiText dbg_vertvel;
UiText dbg_animationCD;
UiText dbg_pose;
UiText dbg_camX;
UiText dbg_camY;
UiText dbg_tutorialPos;
UiText game_displayText;
UiText lebelCompleteText;
UiText lc_fullScreenWarning;
UiText settingPlayerSpawnText;
UiText st_sound;
UiText st_snd_narrationVol;
UiText st_snd_currentNarrationVolume;
UiText narrationCaptionText;
UiText st_o_diableTransitions;
UiText st_o_defaultAuthor;
UiText dbg_ping;

UiSlider musicVolumeSlider;
UiSlider SFXVolumeSlider;
UiSlider verticleEdgeScrollSlider;
UiSlider horozontalEdgeScrollSlider;
UiSlider narrationVolumeSlider;
UiSlider fovSlider;

UiTextBox defaultAuthorNameTextBox;
UiTextBox multyPlayerNameTextBox;
UiTextBox multyPlayerPortTextBox;
UiTextBox multyPlayerIpTextBox;
UiTextBox lcEnterLevelTextBox;
UiTextBox lcNewFileTextBox;

Server server;

SelectedLevelInfo multyplayerSelectedLevel = new SelectedLevelInfo();

LeaderBoard leaderBoard = new LeaderBoard(new String[]{"", "", "", "", "", "", "", "", "", ""});

Point3D initalMousePoint = new Point3D(0, 0, 0);
Point3D initalObjectPos = new Point3D(0, 0, 0);
Point3D initialObjectDim = new Point3D(0, 0, 0);

ArrayList<GlitchBox> glitchBoxes = new ArrayList<>();

PlayerMovementManager playerMovementManager = new PlayerMovementManager();

CollisionDetection collisionDetection = new CollisionDetection();

StatisticManager stats;

SoundHandler soundHandler;

Level level;

Stage workingBlueprint;
Stage blueprints[];
Stage displayBlueprint;

LogicThread logicTickingThread = new LogicThread();

ToolBox scr2;

Identifier currentlyPlaceing = null;


//DO NOT EDIT BELOW THIS LINE ON THE MAIN PROJECT!
//===================================================
//DO NOT EDIT THEESE LINES, EVER
//+++++++++++++++++++++++++++++++++++++++++++++++++++
//===================================================
//reserved for arcade edition vars



//===================================================
//DO NOT EDIT THEESE LINES, EVER
//+++++++++++++++++++++++++++++++++++++++++++++++++++
//===================================================
//reserverd for other external var decaliresion

String errorText = "";
boolean errorScreen = false;
boolean prevLeft = false;
boolean prevRight = false;
boolean prevJump = false;
boolean prevIn = false;
boolean prevOut = false;
boolean prevE = false;

Button moveLeft;
Button moveRight;
Button jumpButton;
Button useButton;
Button movein;
Button moveout;

Button moveInLeft;
Button moveOutLeft;
Button moveOutRight;
Button moveInRight;

//end of vars.pde
