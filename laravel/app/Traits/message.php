<?php

namespace App\Traits;

trait message
{

    public function set_fails_msg(string $msg, int $code = 400, array $headers = [], int $status = 200): \Illuminate\Http\JsonResponse
    {
        $result = [
            'result' => false,
            'msg' => $msg,
            'code' => $code
        ];

        return $this->apiResponse($result, $result['code'], $headers, $status);
    }

    public function apiResponse(array $result, int $error_status = 400, array $headers = [], int $status = 200): \Illuminate\Http\JsonResponse
    {
        $header = [];
        if (count($headers) === 0) {
            $header = [
                'Content-Type' => 'application/json; charset=UTF-8',
                'Charset' => 'utf-8'
            ];
        }
        if ($error_status === 500) {
            $status = $error_status;
        }
        return response()->json($result, $status, $header, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    }
}
