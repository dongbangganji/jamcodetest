<?php

namespace App\Http\Controllers\PersonalTrainer;

use App\Application\PersonalTrainer\PersonalTrainerService;
use App\Http\Controllers\Controller;
use App\Traits\message;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class personalTrainerController extends Controller
{
    use message;

    private PersonalTrainerService $personalTrainer;

    public function __construct(PersonalTrainerService $PersonalTrainer)
    {
        $this->personalTrainer = $PersonalTrainer;
    }

    public function info(request $request)
    {
        $validator = Validator::make($request->all(), [
            'solution_type' => 'in:DIET,FITNESS',
            'lifestyle_tags' => 'required|array|min:1',
            'lifestyle_tags.*' => 'in:enough_money,strong_will,enough_time',
        ]);
        if ($validator->fails()) {
            return $this->set_fails_msg($validator->errors()->first());
        }
        $data = new \stdClass();
        $data->solution_type = $request->get('solution_type');
        $data->lifestyle_tags = $request->get('lifestyle_tags');
        $data = $this->personalTrainer->getSolution($data);
        $result = [
            'result' => true,
            'code' => 200,
            'recommend' => $data
        ];
        return $this->apiResponse($result, $result['code']);
    }
}
