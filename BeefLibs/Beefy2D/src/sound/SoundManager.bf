using System;

namespace Beefy.sound
{
	struct SoundSource : int32
	{
		public bool IsInvalid
		{
			get
			{
				return this == (.)-1;
			}
		}
	}
	
	class SoundManager
	{
		void* mNativeSoundManager;

		[StdCall, CLink]
		public static extern int32 BFSoundManager_LoadSound(void* nativeSoundManager, char8* fileName);

		[StdCall, CLink]
		public static extern void* BFSoundManager_GetSoundInstance(void* nativeSoundManager, int32 sfxId);

		public SoundSource LoadSound(StringView fileName)
		{
			return (.)BFSoundManager_LoadSound(mNativeSoundManager, fileName.ToScopeCStr!());
		}

		public SoundInstance GetSoundInstance(SoundSource soundSource)
		{
			void* nativeSoundInstance = BFSoundManager_GetSoundInstance(mNativeSoundManager, (.)soundSource);
			return .(nativeSoundInstance);
		}

		public void PlaySound(SoundSource soundSource)
		{
			let soundInstance = GetSoundInstance(soundSource);
			soundInstance.Play(false, true);
		}
	}
}
