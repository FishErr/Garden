-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Дек 16 2012 г., 20:05
-- Версия сервера: 5.5.28
-- Версия PHP: 5.4.6-1ubuntu1.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `vanilla`
--

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Activity`
--

CREATE TABLE IF NOT EXISTS `GDN_Activity` (
  `ActivityID` int(11) NOT NULL AUTO_INCREMENT,
  `ActivityTypeID` int(11) NOT NULL,
  `NotifyUserID` int(11) NOT NULL DEFAULT '0',
  `ActivityUserID` int(11) DEFAULT NULL,
  `RegardingUserID` int(11) DEFAULT NULL,
  `Photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `HeadlineFormat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Story` text COLLATE utf8_unicode_ci,
  `Format` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Route` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RecordType` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RecordID` int(11) DEFAULT NULL,
  `InsertUserID` int(11) DEFAULT NULL,
  `DateInserted` datetime NOT NULL,
  `InsertIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DateUpdated` datetime DEFAULT NULL,
  `Notified` tinyint(4) NOT NULL DEFAULT '0',
  `Emailed` tinyint(4) NOT NULL DEFAULT '0',
  `Data` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ActivityID`),
  KEY `IX_Activity_Notify` (`NotifyUserID`,`Notified`),
  KEY `IX_Activity_Recent` (`NotifyUserID`,`DateUpdated`),
  KEY `IX_Activity_Feed` (`NotifyUserID`,`ActivityUserID`,`DateUpdated`),
  KEY `IX_Activity_DateUpdated` (`DateUpdated`),
  KEY `FK_Activity_InsertUserID` (`InsertUserID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Дамп данных таблицы `GDN_Activity`
--

INSERT INTO `GDN_Activity` (`ActivityID`, `ActivityTypeID`, `NotifyUserID`, `ActivityUserID`, `RegardingUserID`, `Photo`, `HeadlineFormat`, `Story`, `Format`, `Route`, `RecordType`, `RecordID`, `InsertUserID`, `DateInserted`, `InsertIPAddress`, `DateUpdated`, `Notified`, `Emailed`, `Data`) VALUES
(3, 20, 3, 1, 3, NULL, NULL, '', NULL, '/messages/2#2', NULL, NULL, 1, '2012-12-15 11:11:14', '127.0.0.1', '2012-12-15 11:11:14', 3, 5, 'a:0:{}'),
(4, 17, -2, 1, 6, NULL, '{ActivityUserID,user} approved the applications for {RegardingUserID,user}.', NULL, NULL, NULL, NULL, NULL, 1, '2012-12-15 11:16:52', '127.0.0.1', '2012-12-15 11:16:52', 0, 0, 'a:0:{}'),
(6, 21, 2, 1, NULL, NULL, '{ActivityUserID,User} added you to a <a href="{Url,htmlencode}">conversation</a>.', NULL, NULL, NULL, NULL, NULL, 1, '2012-12-15 11:30:16', '127.0.0.1', '2012-12-15 11:30:16', 3, 2, 'a:0:{}'),
(7, 20, 2, 1, 2, NULL, NULL, '', NULL, '/messages/2#3', NULL, NULL, 1, '2012-12-15 11:30:23', '127.0.0.1', '2012-12-15 11:30:23', 3, 2, 'a:0:{}');

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_ActivityComment`
--

CREATE TABLE IF NOT EXISTS `GDN_ActivityComment` (
  `ActivityCommentID` int(11) NOT NULL AUTO_INCREMENT,
  `ActivityID` int(11) NOT NULL,
  `Body` text COLLATE utf8_unicode_ci NOT NULL,
  `Format` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `InsertUserID` int(11) NOT NULL,
  `DateInserted` datetime NOT NULL,
  `InsertIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ActivityCommentID`),
  KEY `FK_ActivityComment_ActivityID` (`ActivityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_ActivityType`
--

CREATE TABLE IF NOT EXISTS `GDN_ActivityType` (
  `ActivityTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `AllowComments` tinyint(4) NOT NULL DEFAULT '0',
  `ShowIcon` tinyint(4) NOT NULL DEFAULT '0',
  `ProfileHeadline` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FullHeadline` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RouteCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Notify` tinyint(4) NOT NULL DEFAULT '0',
  `Public` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ActivityTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=30 ;

--
-- Дамп данных таблицы `GDN_ActivityType`
--

INSERT INTO `GDN_ActivityType` (`ActivityTypeID`, `Name`, `AllowComments`, `ShowIcon`, `ProfileHeadline`, `FullHeadline`, `RouteCode`, `Notify`, `Public`) VALUES
(1, 'SignIn', 0, 0, '%1$s signed in.', '%1$s signed in.', NULL, 0, 1),
(2, 'Join', 1, 0, '%1$s joined.', '%1$s joined.', NULL, 0, 1),
(3, 'JoinInvite', 1, 0, '%1$s accepted %4$s invitation for membership.', '%1$s accepted %4$s invitation for membership.', NULL, 0, 1),
(4, 'JoinApproved', 1, 0, '%1$s approved %4$s membership application.', '%1$s approved %4$s membership application.', NULL, 0, 1),
(5, 'JoinCreated', 1, 0, '%1$s created an account for %3$s.', '%1$s created an account for %3$s.', NULL, 0, 1),
(6, 'AboutUpdate', 1, 0, '%1$s updated %6$s profile.', '%1$s updated %6$s profile.', NULL, 0, 1),
(7, 'WallComment', 1, 1, '%1$s wrote:', '%1$s wrote on %4$s %5$s.', NULL, 0, 1),
(8, 'PictureChange', 1, 0, '%1$s changed %6$s profile picture.', '%1$s changed %6$s profile picture.', NULL, 0, 1),
(9, 'RoleChange', 1, 0, '%1$s changed %4$s permissions.', '%1$s changed %4$s permissions.', NULL, 1, 1),
(10, 'ActivityComment', 0, 1, '%1$s', '%1$s commented on %4$s %8$s.', 'activity', 1, 1),
(11, 'Import', 0, 0, '%1$s imported data.', '%1$s imported data.', NULL, 1, 0),
(12, 'Banned', 0, 0, '%1$s banned %3$s.', '%1$s banned %3$s.', NULL, 0, 1),
(13, 'Unbanned', 0, 0, '%1$s un-banned %3$s.', '%1$s un-banned %3$s.', NULL, 0, 1),
(14, 'Applicant', 0, 0, '%1$s applied for membership.', '%1$s applied for membership.', NULL, 1, 0),
(15, 'WallPost', 1, 1, '%3$s wrote:', '%3$s wrote on %2$s %5$s.', NULL, 0, 1),
(16, 'Default', 0, 0, NULL, NULL, NULL, 0, 1),
(17, 'Registration', 0, 0, NULL, NULL, NULL, 0, 1),
(18, 'Status', 0, 0, NULL, NULL, NULL, 0, 1),
(19, 'Ban', 0, 0, NULL, NULL, NULL, 0, 1),
(20, 'ConversationMessage', 0, 0, '%1$s sent you a %8$s.', '%1$s sent you a %8$s.', 'message', 1, 0),
(21, 'AddedToConversation', 0, 0, '%1$s added %3$s to a %8$s.', '%1$s added %3$s to a %8$s.', 'conversation', 1, 0),
(22, 'NewDiscussion', 0, 0, '%1$s started a %8$s.', '%1$s started a %8$s.', 'discussion', 0, 0),
(23, 'NewComment', 0, 0, '%1$s commented on a discussion.', '%1$s commented on a discussion.', 'discussion', 0, 0),
(24, 'DiscussionComment', 0, 0, '%1$s commented on %4$s %8$s.', '%1$s commented on %4$s %8$s.', 'discussion', 1, 0),
(25, 'DiscussionMention', 0, 0, '%1$s mentioned %3$s in a %8$s.', '%1$s mentioned %3$s in a %8$s.', 'discussion', 1, 0),
(26, 'CommentMention', 0, 0, '%1$s mentioned %3$s in a %8$s.', '%1$s mentioned %3$s in a %8$s.', 'comment', 1, 0),
(27, 'BookmarkComment', 0, 0, '%1$s commented on your %8$s.', '%1$s commented on your %8$s.', 'bookmarked discussion', 1, 0),
(28, 'Discussion', 0, 0, NULL, NULL, NULL, 0, 1),
(29, 'Comment', 0, 0, NULL, NULL, NULL, 0, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_AnalyticsLocal`
--

CREATE TABLE IF NOT EXISTS `GDN_AnalyticsLocal` (
  `TimeSlot` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `Views` int(11) DEFAULT NULL,
  `EmbedViews` int(11) DEFAULT NULL,
  UNIQUE KEY `UX_AnalyticsLocal` (`TimeSlot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Ban`
--

CREATE TABLE IF NOT EXISTS `GDN_Ban` (
  `BanID` int(11) NOT NULL AUTO_INCREMENT,
  `BanType` enum('IPAddress','Name','Email') COLLATE utf8_unicode_ci NOT NULL,
  `BanValue` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CountUsers` int(10) unsigned NOT NULL DEFAULT '0',
  `CountBlockedRegistrations` int(10) unsigned NOT NULL DEFAULT '0',
  `InsertUserID` int(11) NOT NULL,
  `DateInserted` datetime NOT NULL,
  PRIMARY KEY (`BanID`),
  UNIQUE KEY `UX_Ban` (`BanType`,`BanValue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Category`
--

CREATE TABLE IF NOT EXISTS `GDN_Category` (
  `CategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `ParentCategoryID` int(11) DEFAULT NULL,
  `TreeLeft` int(11) DEFAULT NULL,
  `TreeRight` int(11) DEFAULT NULL,
  `Depth` int(11) DEFAULT NULL,
  `CountDiscussions` int(11) NOT NULL DEFAULT '0',
  `CountComments` int(11) NOT NULL DEFAULT '0',
  `DateMarkedRead` datetime DEFAULT NULL,
  `AllowDiscussions` tinyint(4) NOT NULL DEFAULT '1',
  `Archived` tinyint(4) NOT NULL DEFAULT '0',
  `Name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `UrlCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Description` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Sort` int(11) DEFAULT NULL,
  `CssClass` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PermissionCategoryID` int(11) NOT NULL DEFAULT '-1',
  `HideAllDiscussions` tinyint(4) NOT NULL DEFAULT '0',
  `DisplayAs` enum('Categories','Discussions','Default') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Default',
  `InsertUserID` int(11) NOT NULL,
  `UpdateUserID` int(11) DEFAULT NULL,
  `DateInserted` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  `LastCommentID` int(11) DEFAULT NULL,
  `LastDiscussionID` int(11) DEFAULT NULL,
  `LastDateInserted` datetime DEFAULT NULL,
  PRIMARY KEY (`CategoryID`),
  KEY `FK_Category_InsertUserID` (`InsertUserID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `GDN_Category`
--

INSERT INTO `GDN_Category` (`CategoryID`, `ParentCategoryID`, `TreeLeft`, `TreeRight`, `Depth`, `CountDiscussions`, `CountComments`, `DateMarkedRead`, `AllowDiscussions`, `Archived`, `Name`, `UrlCode`, `Description`, `Sort`, `CssClass`, `Photo`, `PermissionCategoryID`, `HideAllDiscussions`, `DisplayAs`, `InsertUserID`, `UpdateUserID`, `DateInserted`, `DateUpdated`, `LastCommentID`, `LastDiscussionID`, `LastDateInserted`) VALUES
(-1, NULL, 1, 4, NULL, 0, 0, NULL, 1, 0, 'Root', 'root', 'Root of category tree. Users should never see this.', NULL, NULL, NULL, -1, 0, 'Default', 1, 1, '2012-12-15 10:50:08', '2012-12-15 10:50:08', NULL, NULL, NULL),
(1, -1, 2, 3, NULL, 0, 0, NULL, 1, 0, 'General', 'general', 'General discussions', NULL, NULL, NULL, -1, 0, 'Default', 1, 1, '2012-12-15 10:50:08', '2012-12-15 10:50:08', 1, 1, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Comment`
--

CREATE TABLE IF NOT EXISTS `GDN_Comment` (
  `CommentID` int(11) NOT NULL AUTO_INCREMENT,
  `DiscussionID` int(11) NOT NULL,
  `InsertUserID` int(11) DEFAULT NULL,
  `UpdateUserID` int(11) DEFAULT NULL,
  `DeleteUserID` int(11) DEFAULT NULL,
  `Body` text COLLATE utf8_unicode_ci NOT NULL,
  `Format` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DateInserted` datetime DEFAULT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `DateUpdated` datetime DEFAULT NULL,
  `InsertIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UpdateIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Flag` tinyint(4) NOT NULL DEFAULT '0',
  `Score` float DEFAULT NULL,
  `Attributes` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`CommentID`),
  KEY `IX_Comment_1` (`DiscussionID`,`DateInserted`),
  KEY `IX_Comment_DateInserted` (`DateInserted`),
  KEY `FK_Comment_InsertUserID` (`InsertUserID`),
  FULLTEXT KEY `TX_Comment` (`Body`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Conversation`
--

CREATE TABLE IF NOT EXISTS `GDN_Conversation` (
  `ConversationID` int(11) NOT NULL AUTO_INCREMENT,
  `Subject` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Contributors` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `FirstMessageID` int(11) DEFAULT NULL,
  `InsertUserID` int(11) NOT NULL,
  `DateInserted` datetime DEFAULT NULL,
  `InsertIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UpdateUserID` int(11) NOT NULL,
  `DateUpdated` datetime NOT NULL,
  `UpdateIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CountMessages` int(11) NOT NULL DEFAULT '0',
  `LastMessageID` int(11) DEFAULT NULL,
  `RegardingID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ConversationID`),
  KEY `FK_Conversation_FirstMessageID` (`FirstMessageID`),
  KEY `FK_Conversation_InsertUserID` (`InsertUserID`),
  KEY `FK_Conversation_DateInserted` (`DateInserted`),
  KEY `FK_Conversation_UpdateUserID` (`UpdateUserID`),
  KEY `IX_Conversation_RegardingID` (`RegardingID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `GDN_Conversation`
--

INSERT INTO `GDN_Conversation` (`ConversationID`, `Subject`, `Contributors`, `FirstMessageID`, `InsertUserID`, `DateInserted`, `InsertIPAddress`, `UpdateUserID`, `DateUpdated`, `UpdateIPAddress`, `CountMessages`, `LastMessageID`, `RegardingID`) VALUES
(1, NULL, 'a:2:{i:0;s:1:"2";i:1;s:1:"1";}', NULL, 2, '2012-12-15 10:50:07', NULL, 0, '0000-00-00 00:00:00', NULL, 1, 1, NULL),
(2, NULL, 'a:2:{i:0;i:1;i:1;s:1:"2";}', 2, 1, '2012-12-15 11:11:14', '127.0.0.1', 1, '2012-12-15 11:30:23', '127.0.0.1', 2, 3, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_ConversationMessage`
--

CREATE TABLE IF NOT EXISTS `GDN_ConversationMessage` (
  `MessageID` int(11) NOT NULL AUTO_INCREMENT,
  `ConversationID` int(11) NOT NULL,
  `Body` text COLLATE utf8_unicode_ci NOT NULL,
  `Format` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `InsertUserID` int(11) DEFAULT NULL,
  `DateInserted` datetime NOT NULL,
  `InsertIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MessageID`),
  KEY `FK_ConversationMessage_ConversationID` (`ConversationID`),
  KEY `FK_ConversationMessage_InsertUserID` (`InsertUserID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `GDN_ConversationMessage`
--

INSERT INTO `GDN_ConversationMessage` (`MessageID`, `ConversationID`, `Body`, `Format`, `InsertUserID`, `DateInserted`, `InsertIPAddress`) VALUES
(1, 1, 'Pssst. Hey. A conversation is a private chat between two or more members. No one can see it except the members added. You can delete this one since I&rsquo;m just a bot and know better than to talk back.', 'Html', 2, '2012-12-15 10:50:07', NULL),
(2, 2, 'fsdfds', 'Html', 1, '2012-12-15 11:11:14', '127.0.0.1'),
(3, 2, '&nbsp;fds fds fsd<br>&nbsp;ds fds fsd<br>', 'Wysiwyg', 1, '2012-12-15 11:30:23', '127.0.0.1');

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Discussion`
--

CREATE TABLE IF NOT EXISTS `GDN_Discussion` (
  `DiscussionID` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ForeignID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CategoryID` int(11) NOT NULL,
  `InsertUserID` int(11) NOT NULL,
  `UpdateUserID` int(11) DEFAULT NULL,
  `FirstCommentID` int(11) DEFAULT NULL,
  `LastCommentID` int(11) DEFAULT NULL,
  `Name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Body` text COLLATE utf8_unicode_ci NOT NULL,
  `Format` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tags` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CountComments` int(11) NOT NULL DEFAULT '0',
  `CountBookmarks` int(11) DEFAULT NULL,
  `CountViews` int(11) NOT NULL DEFAULT '1',
  `Closed` tinyint(4) NOT NULL DEFAULT '0',
  `Announce` tinyint(4) NOT NULL DEFAULT '0',
  `Sink` tinyint(4) NOT NULL DEFAULT '0',
  `DateInserted` datetime NOT NULL,
  `DateUpdated` datetime DEFAULT NULL,
  `InsertIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UpdateIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DateLastComment` datetime DEFAULT NULL,
  `LastCommentUserID` int(11) DEFAULT NULL,
  `Score` float DEFAULT NULL,
  `Attributes` text COLLATE utf8_unicode_ci,
  `RegardingID` int(11) DEFAULT NULL,
  PRIMARY KEY (`DiscussionID`),
  KEY `IX_Discussion_Type` (`Type`),
  KEY `IX_Discussion_ForeignID` (`ForeignID`),
  KEY `IX_Discussion_DateInserted` (`DateInserted`),
  KEY `IX_Discussion_DateLastComment` (`DateLastComment`),
  KEY `IX_Discussion_RegardingID` (`RegardingID`),
  KEY `IX_Discussion_CategoryPages` (`CategoryID`,`DateLastComment`),
  KEY `FK_Discussion_CategoryID` (`CategoryID`),
  KEY `FK_Discussion_InsertUserID` (`InsertUserID`),
  FULLTEXT KEY `TX_Discussion` (`Name`,`Body`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Draft`
--

CREATE TABLE IF NOT EXISTS `GDN_Draft` (
  `DraftID` int(11) NOT NULL AUTO_INCREMENT,
  `DiscussionID` int(11) DEFAULT NULL,
  `CategoryID` int(11) DEFAULT NULL,
  `InsertUserID` int(11) NOT NULL,
  `UpdateUserID` int(11) NOT NULL,
  `Name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tags` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Closed` tinyint(4) NOT NULL DEFAULT '0',
  `Announce` tinyint(4) NOT NULL DEFAULT '0',
  `Sink` tinyint(4) NOT NULL DEFAULT '0',
  `Body` text COLLATE utf8_unicode_ci NOT NULL,
  `Format` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DateInserted` datetime NOT NULL,
  `DateUpdated` datetime DEFAULT NULL,
  PRIMARY KEY (`DraftID`),
  KEY `FK_Draft_DiscussionID` (`DiscussionID`),
  KEY `FK_Draft_CategoryID` (`CategoryID`),
  KEY `FK_Draft_InsertUserID` (`InsertUserID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `GDN_Draft`
--

INSERT INTO `GDN_Draft` (`DraftID`, `DiscussionID`, `CategoryID`, `InsertUserID`, `UpdateUserID`, `Name`, `Tags`, `Closed`, `Announce`, `Sink`, `Body`, `Format`, `DateInserted`, `DateUpdated`) VALUES
(1, NULL, 0, 1, 1, '', '', 0, 0, 0, '<span style="background-color: rgb(255, 0, 0);"><br></span>', 'Wysiwyg', '2012-12-15 12:09:50', '2012-12-15 12:09:50');

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Invitation`
--

CREATE TABLE IF NOT EXISTS `GDN_Invitation` (
  `InvitationID` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `Code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `InsertUserID` int(11) DEFAULT NULL,
  `DateInserted` datetime NOT NULL,
  `AcceptedUserID` int(11) DEFAULT NULL,
  PRIMARY KEY (`InvitationID`),
  KEY `FK_Invitation_InsertUserID` (`InsertUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Log`
--

CREATE TABLE IF NOT EXISTS `GDN_Log` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT,
  `Operation` enum('Delete','Edit','Spam','Moderate','Pending','Ban','Error') COLLATE utf8_unicode_ci NOT NULL,
  `RecordType` enum('Discussion','Comment','User','Registration','Activity','ActivityComment','Configuration') COLLATE utf8_unicode_ci NOT NULL,
  `TransactionLogID` int(11) DEFAULT NULL,
  `RecordID` int(11) DEFAULT NULL,
  `RecordUserID` int(11) DEFAULT NULL,
  `RecordDate` datetime NOT NULL,
  `RecordIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `InsertUserID` int(11) NOT NULL,
  `DateInserted` datetime NOT NULL,
  `InsertIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OtherUserIDs` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DateUpdated` datetime DEFAULT NULL,
  `ParentRecordID` int(11) DEFAULT NULL,
  `CategoryID` int(11) DEFAULT NULL,
  `Data` mediumtext COLLATE utf8_unicode_ci,
  `CountGroup` int(11) DEFAULT NULL,
  PRIMARY KEY (`LogID`),
  KEY `IX_Log_RecordType` (`RecordType`),
  KEY `IX_Log_RecordID` (`RecordID`),
  KEY `IX_Log_RecordIPAddress` (`RecordIPAddress`),
  KEY `IX_Log_ParentRecordID` (`ParentRecordID`),
  KEY `FK_Log_CategoryID` (`CategoryID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=33 ;

--
-- Дамп данных таблицы `GDN_Log`
--

INSERT INTO `GDN_Log` (`LogID`, `Operation`, `RecordType`, `TransactionLogID`, `RecordID`, `RecordUserID`, `RecordDate`, `RecordIPAddress`, `InsertUserID`, `DateInserted`, `InsertIPAddress`, `OtherUserIDs`, `DateUpdated`, `ParentRecordID`, `CategoryID`, `Data`, `CountGroup`) VALUES
(1, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 10:50:12', NULL, 1, '2012-12-15 10:50:12', '127.0.0.1', '', NULL, NULL, NULL, 'a:1:{s:4:"_New";a:7:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:1:{s:12:"ConfirmEmail";b:1;}s:5:"Email";a:1:{s:11:"SupportName";s:9:"Vanilla 2";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(2, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 10:50:24', NULL, 1, '2012-12-15 10:50:24', '127.0.0.1', '', NULL, NULL, NULL, 'a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:1:{s:12:"ConfirmEmail";b:1;}s:5:"Email";a:1:{s:11:"SupportName";s:9:"Vanilla 2";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:1:{s:12:"ConfirmEmail";b:1;}s:5:"Email";a:1:{s:11:"SupportName";s:9:"Vanilla 2";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:1:{s:9:"Dashboard";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(3, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 10:53:08', NULL, 1, '2012-12-15 10:53:08', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:1:{s:12:"ConfirmEmail";b:1;}s:5:"Email";a:1:{s:11:"SupportName";s:9:"Vanilla 2";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:1:{s:9:"Dashboard";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:1:{s:11:"SupportName";s:9:"Vanilla 2";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:2:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(4, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:04:44', NULL, 1, '2012-12-15 11:04:44', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:1:{s:11:"SupportName";s:9:"Vanilla 2";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:2:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"587";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:2:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(5, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:14:39', NULL, 1, '2012-12-15 11:14:39', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"587";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:2:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:2:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(6, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:16:14', NULL, 6, '2012-12-15 11:16:14', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:2:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:3:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(7, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:19:18', NULL, 1, '2012-12-15 11:19:18', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:3:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(8, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:19:30', NULL, 1, '2012-12-15 11:19:30', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:3:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(9, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:19:30', NULL, 1, '2012-12-15 11:19:30', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:3:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(10, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:19:33', NULL, 1, '2012-12-15 11:19:33', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:2:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:3:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(11, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:19:45', NULL, 1, '2012-12-15 11:19:45', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:3:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:4:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(12, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:20:11', NULL, 1, '2012-12-15 11:20:11', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:4:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:5:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(13, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:20:30', NULL, 1, '2012-12-15 11:20:30', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:5:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:6:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:8:"Debugger";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(14, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:20:51', NULL, 1, '2012-12-15 11:20:51', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:6:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:8:"Debugger";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:5:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(15, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:20:59', NULL, 1, '2012-12-15 11:20:59', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:5:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;}s:6:"Garden";a:9:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:5:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(16, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:20:59', NULL, 1, '2012-12-15 11:20:59', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:5:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:6:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL);
INSERT INTO `GDN_Log` (`LogID`, `Operation`, `RecordType`, `TransactionLogID`, `RecordID`, `RecordUserID`, `RecordDate`, `RecordIPAddress`, `InsertUserID`, `DateInserted`, `InsertIPAddress`, `OtherUserIDs`, `DateUpdated`, `ParentRecordID`, `CategoryID`, `Data`, `CountGroup`) VALUES
(17, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:22:10', NULL, 1, '2012-12-15 11:22:10', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:6:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:7:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(18, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:22:19', NULL, 1, '2012-12-15 11:22:19', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:7:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:1:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:7:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(19, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:22:19', NULL, 1, '2012-12-15 11:22:19', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:7:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:8:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(20, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:22:36', NULL, 1, '2012-12-15 11:22:36', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:8:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(21, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:22:44', NULL, 1, '2012-12-15 11:22:44', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:10:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(22, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:22:53', NULL, 1, '2012-12-15 11:22:53', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:10:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:9:"ButtonBar";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(23, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:22:57', NULL, 1, '2012-12-15 11:22:57', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;}s:6:"Garden";a:10:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;}s:6:"Garden";a:11:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(24, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:22:57', NULL, 1, '2012-12-15 11:22:57', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;}s:6:"Garden";a:11:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:10:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:11:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(25, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:23:43', NULL, 1, '2012-12-15 11:23:43', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:10:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:11:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:3:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";i:140;}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:8:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:10:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:11:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(26, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:26:52', NULL, 1, '2012-12-15 11:26:52', '127.0.0.1', '', NULL, NULL, NULL, 'a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledPlugins";a:10:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:11:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledLocales";a:1:{s:9:"ruvanilla";s:5:"ru-RU";}s:14:"EnabledPlugins";a:10:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:11:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(27, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:27:53', NULL, 1, '2012-12-15 11:27:53', '127.0.0.1', '', NULL, NULL, NULL, 'a:10:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledLocales";a:1:{s:9:"ruvanilla";s:5:"ru-RU";}s:14:"EnabledPlugins";a:10:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:11:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledLocales";a:1:{s:9:"ruvanilla";s:5:"ru-RU";}s:14:"EnabledPlugins";a:10:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:12:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}s:6:"Locale";s:5:"ru-RU";}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(28, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 11:28:54', NULL, 1, '2012-12-15 11:28:54', '127.0.0.1', '', NULL, NULL, NULL, 'a:10:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledLocales";a:1:{s:9:"ruvanilla";s:5:"ru-RU";}s:14:"EnabledPlugins";a:10:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Buttons";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:12:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}s:6:"Locale";s:5:"ru-RU";}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledLocales";a:1:{s:9:"ruvanilla";s:5:"ru-RU";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:12:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}s:6:"Locale";s:5:"ru-RU";}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(29, 'Delete', 'Discussion', 29, 1, 2, '2012-12-15 10:50:11', NULL, 1, '2012-12-15 11:31:13', '127.0.0.1', '', NULL, NULL, 1, 'a:28:{s:12:"DiscussionID";s:1:"1";s:4:"Type";N;s:9:"ForeignID";s:4:"stub";s:10:"CategoryID";s:1:"1";s:12:"InsertUserID";s:1:"2";s:12:"UpdateUserID";N;s:14:"FirstCommentID";N;s:13:"LastCommentID";s:1:"1";s:4:"Name";s:35:"BAM! You&rsquo;ve got a sweet forum";s:4:"Body";s:974:"There&rsquo;s nothing sweeter than a fresh new forum, ready to welcome your community. A Vanilla Forum has all the bits and pieces you need to build an awesome discussion platform customized to your needs. Here&rsquo;s a few tips:\n<ul>\n<li>Use the <a href="/dashboard/settings/gettingstarted">Getting Started</a> list in the Dashboard to configure your site.</li>\n<li>Don&rsquo;t use too many categories. We recommend 3-8. Keep it simple!\n<li>&ldquo;Announce&rdquo; a discussion (click the gear) to stick to the top of the list, and &ldquo;Close&rdquo; it to stop further comments.</li>\n<li>Use &ldquo;Sink&rdquo; to take attention away from a discussion. New comments will no longer bring it back to the top of the list.</li>\n<li>Bookmark a discussion (click the star) to get notifications for new comments. You can edit notification settings from your profile.</li>\n</ul>\nGo ahead and edit or delete this discussion, then spread the word to get this place cooking. Cheers!";s:6:"Format";s:4:"Html";s:4:"Tags";N;s:13:"CountComments";s:1:"1";s:14:"CountBookmarks";s:1:"1";s:10:"CountViews";s:1:"1";s:6:"Closed";s:1:"0";s:8:"Announce";s:1:"0";s:4:"Sink";s:1:"0";s:12:"DateInserted";s:19:"2012-12-15 10:50:11";s:11:"DateUpdated";N;s:15:"InsertIPAddress";N;s:15:"UpdateIPAddress";N;s:15:"DateLastComment";s:19:"2012-12-15 10:50:11";s:17:"LastCommentUserID";s:1:"2";s:5:"Score";N;s:10:"Attributes";N;s:11:"RegardingID";N;s:5:"_Data";a:1:{s:7:"Comment";a:1:{i:0;a:15:{s:9:"CommentID";s:1:"1";s:12:"DiscussionID";s:1:"1";s:12:"InsertUserID";s:1:"2";s:12:"UpdateUserID";N;s:12:"DeleteUserID";N;s:4:"Body";s:351:"This is the first comment on your site and it&rsquo;s an important one. \n\nDon&rsquo;t see your must-have feature? We keep Vanilla nice and simple by default. Use <b>addons</b> to get the special sauce your community needs.\n\nNot sure which addons to enable? Our favorites are Button Bar and Discussion Photos. They&rsquo;re almost always a great start.";s:6:"Format";s:4:"Html";s:12:"DateInserted";s:19:"2012-12-15 10:50:11";s:11:"DateDeleted";N;s:11:"DateUpdated";N;s:15:"InsertIPAddress";N;s:15:"UpdateIPAddress";N;s:4:"Flag";s:1:"0";s:5:"Score";N;s:10:"Attributes";N;}}}}', NULL);
INSERT INTO `GDN_Log` (`LogID`, `Operation`, `RecordType`, `TransactionLogID`, `RecordID`, `RecordUserID`, `RecordDate`, `RecordIPAddress`, `InsertUserID`, `DateInserted`, `InsertIPAddress`, `OtherUserIDs`, `DateUpdated`, `ParentRecordID`, `CategoryID`, `Data`, `CountGroup`) VALUES
(30, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 12:08:50', NULL, 1, '2012-12-15 12:08:50', '127.0.0.1', '', NULL, NULL, NULL, 'a:10:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledLocales";a:1:{s:9:"ruvanilla";s:5:"ru-RU";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:12:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}s:6:"Locale";s:5:"ru-RU";}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:4:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledLocales";a:1:{s:9:"ruvanilla";s:5:"ru-RU";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:12:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}s:6:"Locale";s:5:"ru-RU";}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:5:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";s:10:"Discussion";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(31, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 14:53:21', NULL, 1, '2012-12-15 14:53:21', '127.0.0.1', '', NULL, NULL, NULL, 'a:10:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledLocales";a:1:{s:9:"ruvanilla";s:5:"ru-RU";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:12:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}s:6:"Locale";s:5:"ru-RU";}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:5:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";s:10:"Discussion";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledLocales";a:1:{s:9:"ruvanilla";s:5:"ru-RU";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:12:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}s:6:"Locale";s:5:"ru-RU";}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:5:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";s:10:"Discussion";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL),
(32, 'Edit', 'Configuration', NULL, NULL, NULL, '2012-12-15 14:53:27', NULL, 1, '2012-12-15 14:53:27', '127.0.0.1', '', NULL, NULL, NULL, 'a:10:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledLocales";a:1:{s:9:"ruvanilla";s:5:"ru-RU";}s:14:"EnabledPlugins";a:9:{s:14:"GettingStarted";s:14:"GettingStarted";s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:12:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}s:6:"Locale";s:5:"ru-RU";}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:5:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";s:10:"Discussion";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:4:"_New";a:9:{s:13:"Conversations";a:1:{s:7:"Version";s:7:"2.1b1.8";}s:8:"Database";a:4:{s:4:"Name";s:7:"vanilla";s:4:"Host";s:9:"localhost";s:4:"User";s:4:"root";s:8:"Password";s:6:"911911";}s:19:"EnabledApplications";a:2:{s:13:"Conversations";s:13:"conversations";s:7:"Vanilla";s:7:"vanilla";}s:14:"EnabledLocales";a:1:{s:9:"ruvanilla";s:5:"ru-RU";}s:14:"EnabledPlugins";a:8:{s:8:"HtmLawed";s:8:"HtmLawed";s:9:"AllViewed";b:1;s:7:"Emotify";b:1;s:23:"VanillaInThisDiscussion";b:1;s:15:"ProfileExtender";b:1;s:7:"Sprites";b:1;s:7:"Tagging";b:1;s:8:"cleditor";b:1;}s:6:"Garden";a:12:{s:5:"Title";s:9:"Vanilla 2";s:6:"Cookie";a:2:{s:4:"Salt";s:10:"53RPRRRSFD";s:6:"Domain";s:0:"";}s:12:"Registration";a:7:{s:12:"ConfirmEmail";s:1:"1";s:6:"Method";s:8:"Approval";s:16:"ConfirmEmailRole";s:1:"3";s:17:"CaptchaPrivateKey";s:0:"";s:16:"CaptchaPublicKey";s:0:"";s:16:"InviteExpiration";s:7:"-1 week";s:11:"InviteRoles";a:5:{i:3;s:1:"0";i:4;s:1:"0";i:8;s:1:"0";i:32;s:1:"0";i:16;s:1:"0";}}s:5:"Email";a:8:{s:11:"SupportName";s:9:"Vanilla 2";s:14:"SupportAddress";s:18:"pvalex81@gmail.com";s:7:"UseSmtp";s:1:"1";s:8:"SmtpHost";s:14:"smtp.gmail.com";s:8:"SmtpUser";s:26:"pavel.alexeyenko@gmail.com";s:12:"SmtpPassword";s:12:"crembocrombo";s:8:"SmtpPort";s:3:"465";s:12:"SmtpSecurity";s:3:"ssl";}s:7:"Version";s:7:"2.1b1.8";s:11:"RewriteUrls";b:0;s:16:"CanProcessImages";b:1;s:12:"SystemUserID";s:1:"2";s:9:"Installed";b:1;s:6:"Format";a:1:{s:8:"Hashtags";b:0;}s:4:"Html";a:1:{s:10:"SafeStyles";b:0;}s:6:"Locale";s:5:"ru-RU";}s:7:"Plugins";a:2:{s:14:"GettingStarted";a:6:{s:9:"Dashboard";s:1:"1";s:12:"Registration";s:1:"1";s:7:"Profile";s:1:"1";s:7:"Plugins";s:1:"1";s:10:"Discussion";s:1:"1";s:10:"Categories";s:1:"1";}s:15:"ProfileExtender";a:4:{s:13:"ProfileFields";s:33:"Location,Facebook,Twitter,Website";s:18:"RegistrationFields";s:8:"Location";s:13:"TextMaxLength";s:3:"140";s:10:"HideFields";s:0:"";}}s:6:"Routes";a:1:{s:17:"DefaultController";s:11:"discussions";}s:7:"Vanilla";a:1:{s:7:"Version";s:7:"2.1b1.8";}}}', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Media`
--

CREATE TABLE IF NOT EXISTS `GDN_Media` (
  `MediaID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Type` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `Size` int(11) NOT NULL,
  `InsertUserID` int(11) NOT NULL,
  `DateInserted` datetime NOT NULL,
  `ForeignID` int(11) DEFAULT NULL,
  `ForeignTable` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ImageWidth` smallint(5) unsigned DEFAULT NULL,
  `ImageHeight` smallint(5) unsigned DEFAULT NULL,
  `ThumbWidth` smallint(5) unsigned DEFAULT NULL,
  `ThumbHeight` smallint(5) unsigned DEFAULT NULL,
  `ThumbPath` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MediaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Message`
--

CREATE TABLE IF NOT EXISTS `GDN_Message` (
  `MessageID` int(11) NOT NULL AUTO_INCREMENT,
  `Content` text COLLATE utf8_unicode_ci NOT NULL,
  `Format` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AllowDismiss` tinyint(4) NOT NULL DEFAULT '1',
  `Enabled` tinyint(4) NOT NULL DEFAULT '1',
  `Application` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Controller` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Method` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AssetTarget` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CssClass` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`MessageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Permission`
--

CREATE TABLE IF NOT EXISTS `GDN_Permission` (
  `PermissionID` int(11) NOT NULL AUTO_INCREMENT,
  `RoleID` int(11) NOT NULL DEFAULT '0',
  `JunctionTable` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `JunctionColumn` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `JunctionID` int(11) DEFAULT NULL,
  `Garden.Email.View` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Email.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Settings.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Settings.View` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Routes.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Messages.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Applications.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Plugins.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Themes.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.SignIn.Allow` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Registration.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Roles.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Users.Add` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Users.Edit` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Users.Delete` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Users.Approve` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Activity.Delete` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Activity.View` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Profiles.View` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Profiles.Edit` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Curation.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.Moderation.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Garden.AdvancedNotifications.Allow` tinyint(4) NOT NULL DEFAULT '0',
  `Conversations.Moderation.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Settings.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Categories.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Approval.Require` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Comments.Me` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Discussions.View` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Discussions.Add` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Discussions.Edit` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Discussions.Announce` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Discussions.Sink` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Discussions.Close` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Discussions.Delete` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Comments.Add` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Comments.Edit` tinyint(4) NOT NULL DEFAULT '0',
  `Vanilla.Comments.Delete` tinyint(4) NOT NULL DEFAULT '0',
  `Plugins.Debugger.View` tinyint(4) NOT NULL DEFAULT '0',
  `Plugins.Debugger.Manage` tinyint(4) NOT NULL DEFAULT '0',
  `Plugins.ProfileExtender.Add` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`PermissionID`),
  KEY `FK_Permission_RoleID` (`RoleID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

--
-- Дамп данных таблицы `GDN_Permission`
--

INSERT INTO `GDN_Permission` (`PermissionID`, `RoleID`, `JunctionTable`, `JunctionColumn`, `JunctionID`, `Garden.Email.View`, `Garden.Email.Manage`, `Garden.Settings.Manage`, `Garden.Settings.View`, `Garden.Routes.Manage`, `Garden.Messages.Manage`, `Garden.Applications.Manage`, `Garden.Plugins.Manage`, `Garden.Themes.Manage`, `Garden.SignIn.Allow`, `Garden.Registration.Manage`, `Garden.Roles.Manage`, `Garden.Users.Add`, `Garden.Users.Edit`, `Garden.Users.Delete`, `Garden.Users.Approve`, `Garden.Activity.Delete`, `Garden.Activity.View`, `Garden.Profiles.View`, `Garden.Profiles.Edit`, `Garden.Curation.Manage`, `Garden.Moderation.Manage`, `Garden.AdvancedNotifications.Allow`, `Conversations.Moderation.Manage`, `Vanilla.Settings.Manage`, `Vanilla.Categories.Manage`, `Vanilla.Approval.Require`, `Vanilla.Comments.Me`, `Vanilla.Discussions.View`, `Vanilla.Discussions.Add`, `Vanilla.Discussions.Edit`, `Vanilla.Discussions.Announce`, `Vanilla.Discussions.Sink`, `Vanilla.Discussions.Close`, `Vanilla.Discussions.Delete`, `Vanilla.Comments.Add`, `Vanilla.Comments.Edit`, `Vanilla.Comments.Delete`, `Plugins.Debugger.View`, `Plugins.Debugger.Manage`, `Plugins.ProfileExtender.Add`) VALUES
(1, 0, NULL, NULL, NULL, 3, 2, 2, 2, 2, 2, 2, 2, 2, 3, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 0, 2, 2, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2),
(2, 2, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 3, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 4, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 8, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
(6, 32, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0),
(7, 16, NULL, NULL, NULL, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0),
(8, 0, 'Category', 'PermissionCategoryID', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 2, 2, 2, 2, 2, 3, 2, 2, 0, 0, 0),
(9, 2, 'Category', 'PermissionCategoryID', -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 4, 'Category', 'PermissionCategoryID', -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11, 8, 'Category', 'PermissionCategoryID', -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
(12, 32, 'Category', 'PermissionCategoryID', -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0),
(13, 16, 'Category', 'PermissionCategoryID', -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Regarding`
--

CREATE TABLE IF NOT EXISTS `GDN_Regarding` (
  `RegardingID` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `InsertUserID` int(11) NOT NULL,
  `DateInserted` datetime NOT NULL,
  `ForeignType` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `ForeignID` int(11) NOT NULL,
  `OriginalContent` text COLLATE utf8_unicode_ci,
  `ParentType` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ParentID` int(11) DEFAULT NULL,
  `ForeignURL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Comment` text COLLATE utf8_unicode_ci NOT NULL,
  `Reports` int(11) DEFAULT NULL,
  PRIMARY KEY (`RegardingID`),
  KEY `FK_Regarding_Type` (`Type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Role`
--

CREATE TABLE IF NOT EXISTS `GDN_Role` (
  `RoleID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Description` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Sort` int(11) DEFAULT NULL,
  `Deletable` tinyint(4) NOT NULL DEFAULT '1',
  `CanSession` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=33 ;

--
-- Дамп данных таблицы `GDN_Role`
--

INSERT INTO `GDN_Role` (`RoleID`, `Name`, `Description`, `Sort`, `Deletable`, `CanSession`) VALUES
(2, 'Guest', 'Guests can only view content. Anyone browsing the site who is not signed in is considered to be a "Guest".', 1, 0, 0),
(3, 'Unconfirmed', 'Users must confirm their emails before becoming full members. They get assigned to this role.', 2, 1, 1),
(4, 'Applicant', 'Users who have applied for membership, but have not yet been accepted. They have the same permissions as guests.', 3, 0, 1),
(8, 'Member', 'Members can participate in discussions.', 4, 1, 1),
(16, 'Administrator', 'Administrators have permission to do anything.', 6, 1, 1),
(32, 'Moderator', 'Moderators have permission to edit most content.', 5, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Session`
--

CREATE TABLE IF NOT EXISTS `GDN_Session` (
  `SessionID` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `UserID` int(11) NOT NULL DEFAULT '0',
  `DateInserted` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  `TransientKey` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `Attributes` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`SessionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Spammer`
--

CREATE TABLE IF NOT EXISTS `GDN_Spammer` (
  `UserID` int(11) NOT NULL,
  `CountSpam` smallint(5) unsigned NOT NULL DEFAULT '0',
  `CountDeletedSpam` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_Tag`
--

CREATE TABLE IF NOT EXISTS `GDN_Tag` (
  `TagID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `InsertUserID` int(11) DEFAULT NULL,
  `DateInserted` datetime NOT NULL,
  `CategoryID` int(11) NOT NULL DEFAULT '-1',
  `CountDiscussions` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`TagID`),
  UNIQUE KEY `UX_Tag` (`Name`,`CategoryID`),
  KEY `IX_Tag_Type` (`Type`),
  KEY `FK_Tag_InsertUserID` (`InsertUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_TagDiscussion`
--

CREATE TABLE IF NOT EXISTS `GDN_TagDiscussion` (
  `TagID` int(11) NOT NULL,
  `DiscussionID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `DateInserted` datetime DEFAULT NULL,
  PRIMARY KEY (`TagID`,`DiscussionID`),
  KEY `IX_TagDiscussion_CategoryID` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_User`
--

CREATE TABLE IF NOT EXISTS `GDN_User` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Password` varbinary(100) NOT NULL,
  `HashMethod` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Location` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `About` text COLLATE utf8_unicode_ci,
  `Email` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `ShowEmail` tinyint(4) NOT NULL DEFAULT '0',
  `Gender` enum('u','m','f') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'u',
  `CountVisits` int(11) NOT NULL DEFAULT '0',
  `CountInvitations` int(11) NOT NULL DEFAULT '0',
  `CountNotifications` int(11) DEFAULT NULL,
  `InviteUserID` int(11) DEFAULT NULL,
  `DiscoveryText` text COLLATE utf8_unicode_ci,
  `Preferences` text COLLATE utf8_unicode_ci,
  `Permissions` text COLLATE utf8_unicode_ci,
  `Attributes` text COLLATE utf8_unicode_ci,
  `DateSetInvitations` datetime DEFAULT NULL,
  `DateOfBirth` datetime DEFAULT NULL,
  `DateFirstVisit` datetime DEFAULT NULL,
  `DateLastActive` datetime DEFAULT NULL,
  `LastIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AllIPAddresses` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DateInserted` datetime NOT NULL,
  `InsertIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DateUpdated` datetime DEFAULT NULL,
  `UpdateIPAddress` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `HourOffset` int(11) NOT NULL DEFAULT '0',
  `Score` float DEFAULT NULL,
  `Admin` tinyint(4) NOT NULL DEFAULT '0',
  `Verified` tinyint(4) NOT NULL DEFAULT '0',
  `Banned` tinyint(4) NOT NULL DEFAULT '0',
  `Deleted` tinyint(4) NOT NULL DEFAULT '0',
  `Points` int(11) NOT NULL DEFAULT '0',
  `CountUnreadConversations` int(11) DEFAULT NULL,
  `CountDiscussions` int(11) DEFAULT NULL,
  `CountUnreadDiscussions` int(11) DEFAULT NULL,
  `CountComments` int(11) DEFAULT NULL,
  `CountDrafts` int(11) DEFAULT NULL,
  `CountBookmarks` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  KEY `FK_User_Name` (`Name`),
  KEY `IX_User_Email` (`Email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `GDN_User`
--

INSERT INTO `GDN_User` (`UserID`, `Name`, `Password`, `HashMethod`, `Photo`, `Title`, `Location`, `About`, `Email`, `ShowEmail`, `Gender`, `CountVisits`, `CountInvitations`, `CountNotifications`, `InviteUserID`, `DiscoveryText`, `Preferences`, `Permissions`, `Attributes`, `DateSetInvitations`, `DateOfBirth`, `DateFirstVisit`, `DateLastActive`, `LastIPAddress`, `AllIPAddresses`, `DateInserted`, `InsertIPAddress`, `DateUpdated`, `UpdateIPAddress`, `HourOffset`, `Score`, `Admin`, `Verified`, `Banned`, `Deleted`, `Points`, `CountUnreadConversations`, `CountDiscussions`, `CountUnreadDiscussions`, `CountComments`, `CountDrafts`, `CountBookmarks`) VALUES
(1, 'FishErr', '$P$BXisFjH5.Uh900RuNVL.79W5M6XBab0', 'Vanilla', NULL, NULL, NULL, 'кефир?', 'pvalex81@gmail.com', 0, 'u', 2, 0, NULL, NULL, NULL, NULL, '', 'a:1:{s:12:"TransientKey";s:12:"M1XDGU2H7ATG";}', NULL, '1975-09-16 00:00:00', '2012-12-15 10:50:06', '2012-12-15 14:56:28', '127.0.0.1', '127.0.0.1', '2012-12-15 10:50:06', '127.0.0.1', '2012-12-15 10:50:06', NULL, 0, NULL, 1, 0, 0, 0, 0, 0, 0, NULL, 0, 1, NULL),
(2, 'System', '5DV3RCAZ7FKRZDFNPI1P', 'Random', 'http://vanilla.pv/applications/dashboard/design/images/usericon.png', NULL, NULL, NULL, 'system@domain.com', 0, 'u', 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-12-15 10:50:07', NULL, NULL, NULL, 0, NULL, 2, 0, 0, 0, 0, 1, 0, NULL, NULL, NULL, NULL),
(3, '[Deleted User]', 'U2865K1XVV', 'Vanilla', NULL, NULL, NULL, '', 'user_3@deleted.email', 0, 'u', 0, 0, 0, NULL, '', NULL, '', 'a:1:{s:5:"State";s:7:"Deleted";}', NULL, NULL, '2012-12-15 10:53:44', '2012-12-15 10:53:44', '127.0.0.1', NULL, '2012-12-15 10:53:44', '127.0.0.1', '2012-12-15 11:17:39', '127.0.0.1', 0, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
(4, '[Deleted User]', 'WBNXGZTLX4', 'Vanilla', NULL, NULL, NULL, '', 'user_4@deleted.email', 0, 'u', 0, 0, 0, NULL, '', NULL, '', 'a:1:{s:5:"State";s:7:"Deleted";}', NULL, NULL, '2012-12-15 11:05:59', '2012-12-15 11:05:59', '127.0.0.1', NULL, '2012-12-15 11:05:59', '127.0.0.1', '2012-12-15 11:17:20', NULL, 0, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
(5, '[Deleted User]', '75E26BSGSB', 'Vanilla', NULL, NULL, NULL, '', 'user_5@deleted.email', 0, 'u', 0, 0, 0, NULL, '', NULL, '', 'a:1:{s:5:"State";s:7:"Deleted";}', NULL, NULL, '2012-12-15 11:12:17', '2012-12-15 11:12:17', '127.0.0.1', NULL, '2012-12-15 11:12:17', '127.0.0.1', '2012-12-15 11:17:30', NULL, 0, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
(6, 'fish12', '$P$BNXBhmaCuYk4BSj3ff3C5Xkdz/De410', 'Vanilla', NULL, NULL, NULL, NULL, 'pvalex81+2@gmail.com', 0, 'm', 0, 0, NULL, NULL, 'Just for testing', NULL, '', 'a:2:{s:12:"TransientKey";s:12:"2Y0A3OJ6IZRJ";s:16:"ApprovedByUserID";s:1:"1";}', NULL, NULL, '2012-12-15 11:14:54', '2012-12-15 11:19:56', '127.0.0.1', '127.0.0.1', '2012-12-15 11:14:54', '127.0.0.1', '2012-12-15 11:16:13', '127.0.0.1', 0, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_UserAuthentication`
--

CREATE TABLE IF NOT EXISTS `GDN_UserAuthentication` (
  `ForeignUserKey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ProviderKey` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `UserID` int(11) NOT NULL,
  PRIMARY KEY (`ForeignUserKey`,`ProviderKey`),
  KEY `FK_UserAuthentication_UserID` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_UserAuthenticationNonce`
--

CREATE TABLE IF NOT EXISTS `GDN_UserAuthenticationNonce` (
  `Nonce` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `Token` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Nonce`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_UserAuthenticationProvider`
--

CREATE TABLE IF NOT EXISTS `GDN_UserAuthenticationProvider` (
  `AuthenticationKey` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `AuthenticationSchemeAlias` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AssociationSecret` text COLLATE utf8_unicode_ci,
  `AssociationHashMethod` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AuthenticateUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RegisterUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SignInUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SignOutUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PasswordUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ProfileUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Attributes` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`AuthenticationKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_UserAuthenticationToken`
--

CREATE TABLE IF NOT EXISTS `GDN_UserAuthenticationToken` (
  `Token` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `ProviderKey` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `ForeignUserKey` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TokenSecret` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `TokenType` enum('request','access') COLLATE utf8_unicode_ci NOT NULL,
  `Authorized` tinyint(4) NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Lifetime` int(11) NOT NULL,
  PRIMARY KEY (`Token`,`ProviderKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_UserCategory`
--

CREATE TABLE IF NOT EXISTS `GDN_UserCategory` (
  `UserID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `DateMarkedRead` datetime DEFAULT NULL,
  `Unfollow` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`UserID`,`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_UserComment`
--

CREATE TABLE IF NOT EXISTS `GDN_UserComment` (
  `UserID` int(11) NOT NULL,
  `CommentID` int(11) NOT NULL,
  `Score` float DEFAULT NULL,
  `DateLastViewed` datetime DEFAULT NULL,
  PRIMARY KEY (`UserID`,`CommentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_UserConversation`
--

CREATE TABLE IF NOT EXISTS `GDN_UserConversation` (
  `UserID` int(11) NOT NULL,
  `ConversationID` int(11) NOT NULL,
  `CountReadMessages` int(11) NOT NULL DEFAULT '0',
  `LastMessageID` int(11) DEFAULT NULL,
  `DateLastViewed` datetime DEFAULT NULL,
  `DateCleared` datetime DEFAULT NULL,
  `Bookmarked` tinyint(4) NOT NULL DEFAULT '0',
  `Deleted` tinyint(4) NOT NULL DEFAULT '0',
  `DateConversationUpdated` datetime DEFAULT NULL,
  PRIMARY KEY (`UserID`,`ConversationID`),
  KEY `IX_UserConversation_Inbox` (`UserID`,`Deleted`,`DateConversationUpdated`),
  KEY `FK_UserConversation_ConversationID` (`ConversationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `GDN_UserConversation`
--

INSERT INTO `GDN_UserConversation` (`UserID`, `ConversationID`, `CountReadMessages`, `LastMessageID`, `DateLastViewed`, `DateCleared`, `Bookmarked`, `Deleted`, `DateConversationUpdated`) VALUES
(1, 1, 1, 1, '2012-12-15 11:30:49', NULL, 0, 1, '2012-12-15 10:50:07'),
(1, 2, 2, 3, '2012-12-15 11:31:00', NULL, 0, 1, '2012-12-15 11:30:23'),
(2, 2, 0, 2, NULL, NULL, 0, 0, '2012-12-15 11:30:23');

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_UserDiscussion`
--

CREATE TABLE IF NOT EXISTS `GDN_UserDiscussion` (
  `UserID` int(11) NOT NULL,
  `DiscussionID` int(11) NOT NULL,
  `Score` float DEFAULT NULL,
  `CountComments` int(11) NOT NULL DEFAULT '0',
  `DateLastViewed` datetime DEFAULT NULL,
  `Dismissed` tinyint(4) NOT NULL DEFAULT '0',
  `Bookmarked` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`UserID`,`DiscussionID`),
  KEY `FK_UserDiscussion_DiscussionID` (`DiscussionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_UserMeta`
--

CREATE TABLE IF NOT EXISTS `GDN_UserMeta` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Value` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`UserID`,`Name`),
  KEY `IX_UserMeta_Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_UserPoints`
--

CREATE TABLE IF NOT EXISTS `GDN_UserPoints` (
  `SlotType` enum('d','w','m','y','a') COLLATE utf8_unicode_ci NOT NULL,
  `TimeSlot` datetime NOT NULL,
  `Source` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Total',
  `UserID` int(11) NOT NULL,
  `Points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`SlotType`,`TimeSlot`,`Source`,`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `GDN_UserRole`
--

CREATE TABLE IF NOT EXISTS `GDN_UserRole` (
  `UserID` int(11) NOT NULL,
  `RoleID` int(11) NOT NULL,
  PRIMARY KEY (`UserID`,`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `GDN_UserRole`
--

INSERT INTO `GDN_UserRole` (`UserID`, `RoleID`) VALUES
(0, 2),
(1, 16),
(6, 8);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
