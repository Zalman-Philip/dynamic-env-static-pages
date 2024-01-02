interface Window {
  _env_?: {
    BASE_URL?: string;
  };
}

export const BASE_URL =
  (window as unknown as Window)._env_?.BASE_URL || "www.example.com";
