abstract class SocialStates {}

class InitialState extends SocialStates {}

class ChangeBottomNavState extends SocialStates {}

class NewPostState extends SocialStates {}

/// update user
class UserUpdateLoadingState extends SocialStates {}

class UserUpdateErrorState extends SocialStates {}

/// end update user

/// get user
class GetUserSuccessState extends SocialStates {}

class GetUserLoadingState extends SocialStates {}

class GetUserErrorState extends SocialStates {}

/// end get user

/// get all user
class GetAllUsersSuccessState extends SocialStates {}

class GetAllUsersLoadingState extends SocialStates {}

class GetAllUsersErrorState extends SocialStates {}

/// end get all user

/// get user
class GetPostsSuccessState extends SocialStates {}

class GetPostsLoadingState extends SocialStates {}

class GetPostsErrorState extends SocialStates {}

/// end get user

/// profile image picker
class ProfileImagePickedSuccessState extends SocialStates {}

class ProfileImagePickedErrorState extends SocialStates {}

/// end profile image picker
///
/// post image picker
class PostImagePickedSuccessState extends SocialStates {}

class PostImagePickedErrorState extends SocialStates {}

class RemovePostImagePickedState extends SocialStates {}

/// end post image picker

/// cover image picker
class CoverImagePickedSuccessState extends SocialStates {}

class CoverImagePickedErrorState extends SocialStates {}

/// end cover image picker

/// upload profile
class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {}

/// end upload profile

/// upload cover
class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}

/// end upload cover

/// create post
class CreatePostLoadingState extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostErrorState extends SocialStates {}

/// end create post

/// like post
class LikePostLoadingState extends SocialStates {}

class LikePostSuccessState extends SocialStates {}

class LikePostErrorState extends SocialStates {}

/// end create post

/// comment post
class CommentPostLoadingState extends SocialStates {}

class CommentPostSuccessState extends SocialStates {}

class CommentPostErrorState extends SocialStates {}

/// end create post
///
/// chat
class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}

class GetMessagesSuccessState extends SocialStates {}

class GetMessagesErrorState extends SocialStates {}

/// end chat
